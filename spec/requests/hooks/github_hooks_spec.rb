require 'rails_helper'

describe 'GitHub hooks', subdomain: 'hooks' do
  let(:service) { FactoryBot.create :github_service }

  context 'unknown event' do
    it 'creates a general hook' do
      project = service.projects.create name: 'jonallured/cybertail-rails'

      params = {
        repository: {
          full_name: 'jonallured/cybertail-rails'
        }
      }

      headers = { 'X-GitHub-Event' => 'unknown' }

      post "/v1/#{project.token}", params: params, headers: headers

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook).to_not be_suppress
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq "Got event unknown, saved as Hook #{hook.id}."
      expect(hook.url).to eq 'https://github.com'
    end
  end

  context 'ping event' do
    it 'creates a suppressed hook' do
      project = service.projects.create name: 'jonallured/cybertail-rails'

      params = {
        repository: {
          full_name: 'jonallured/cybertail-rails'
        }
      }

      headers = { 'X-GitHub-Event' => 'ping' }

      post "/v1/#{project.token}", params: params, headers: headers

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook).to be_suppress
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq nil
      expect(hook.url).to eq nil
    end
  end

  context 'create event' do
    it 'something' do
      project = service.projects.create name: 'jonallured/cybertail-rails'

      params = {
        sender: { login: 'jonallured' },
        ref: 'tmp',
        ref_type: 'branch',
        repository: {
          full_name: 'jonallured/cybertail-rails',
          html_url: 'https://github.com/jonallured/cybertail-rails'
        }
      }

      headers = { 'X-GitHub-Event' => 'create' }

      post "/v1/#{project.token}", params: params, headers: headers

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq 'jonallured created branch "tmp"'
      expect(hook.url).to eq 'https://github.com/jonallured/cybertail-rails/tree/tmp'
    end
  end

  context 'delete event' do
    it 'something' do
      project = service.projects.create name: 'jonallured/cybertail-rails'

      params = {
        sender: { login: 'jonallured' },
        ref: 'tmp',
        ref_type: 'branch',
        repository: {
          full_name: 'jonallured/cybertail-rails',
          html_url: 'https://github.com/jonallured/cybertail-rails'
        }
      }

      headers = { 'X-GitHub-Event' => 'delete' }

      post "/v1/#{project.token}", params: params, headers: headers

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq 'jonallured deleted branch "tmp"'
      expect(hook.url).to eq 'https://github.com/jonallured/cybertail-rails'
    end
  end

  context 'push event' do
    context 'with no commits' do
      it 'creates a suppressed GitHub push Hook' do
        project = service.projects.create name: 'jonallured/cybertail-rails'

        params = {
          commits: [],
          compare: 'https://github.com/jonallured/cybertail-rails/compare/sha1...sha2',
          pusher: { name: 'jonallured' },
          ref: 'refs/heads/master',
          repository: { full_name: 'jonallured/cybertail-rails' }
        }

        headers = { 'X-GitHub-Event' => 'push' }

        post "/v1/#{project.token}", params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook).to be_suppress
        expect(hook.service_id).to eq service.id
        expect(hook.message).to eq 'jonallured pushed 0 commits to master'
        expect(hook.url).to eq 'https://github.com/jonallured/cybertail-rails/compare/sha1...sha2'
      end
    end

    context 'with some commits' do
      it 'creates a GitHub push Hook' do
        project = service.projects.create name: 'jonallured/cybertail-rails'

        params = {
          commits: %w[a b],
          compare: 'https://github.com/jonallured/cybertail-rails/compare/sha1...sha2',
          pusher: { name: 'jonallured' },
          ref: 'refs/heads/master',
          repository: { full_name: 'jonallured/cybertail-rails' }
        }

        headers = { 'X-GitHub-Event' => 'push' }

        post "/v1/#{project.token}", params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook.service_id).to eq service.id
        expect(hook.message).to eq 'jonallured pushed 2 commits to master'
        expect(hook.url).to eq 'https://github.com/jonallured/cybertail-rails/compare/sha1...sha2'
      end
    end
  end

  context 'travis status event' do
    context 'travis push' do
      it 'creates a suppressed GitHub travis Hook' do
        project = service.projects.create name: 'jonallured/cybertail-rails'

        params = {
          context: 'continuous-integration/travis-ci/push',
          repository: { full_name: 'jonallured/cybertail-rails' }
        }

        headers = { 'X-GitHub-Event' => 'status' }

        post "/v1/#{project.token}", params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook).to be_suppress
        expect(hook.service_id).to eq service.id
        expect(hook.message).to eq nil
        expect(hook.url).to eq nil
      end
    end

    context 'travis pr' do
      it 'creates a suppressed GitHub travis Hook' do
        project = service.projects.create name: 'jonallured/cybertail-rails'

        params = {
          context: 'continuous-integration/travis-ci/pr',
          repository: { full_name: 'jonallured/cybertail-rails' }
        }

        headers = { 'X-GitHub-Event' => 'status' }

        post "/v1/#{project.token}", params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook).to be_suppress
        expect(hook.service_id).to eq service.id
        expect(hook.message).to eq nil
        expect(hook.url).to eq nil
      end
    end

    context 'with some commits' do
      it 'creates a GitHub push Hook' do
        project = service.projects.create name: 'jonallured/cybertail-rails'

        params = {
          commits: %w[a b],
          compare: 'https://github.com/jonallured/cybertail-rails/compare/sha1...sha2',
          pusher: { name: 'jonallured' },
          ref: 'refs/heads/master',
          repository: { full_name: 'jonallured/cybertail-rails' }
        }

        headers = { 'X-GitHub-Event' => 'push' }

        post "/v1/#{project.token}", params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook.service_id).to eq service.id
        expect(hook.message).to eq 'jonallured pushed 2 commits to master'
        expect(hook.url).to eq 'https://github.com/jonallured/cybertail-rails/compare/sha1...sha2'
      end
    end
  end

  context 'watching' do
    context 'create' do
      it 'creates a Hook' do
        project = service.projects.create name: 'jonallured/cybertail-rails'

        params = {
          sender: {
            login: 'jonallured',
            html_url: 'https://github.com/jonallured'
          },
          repository: { full_name: 'jonallured/cybertail-rails' }
        }

        headers = { 'X-GitHub-Event' => 'watch' }

        post "/v1/#{project.token}", params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook.service_id).to eq service.id
        expect(hook.message).to eq 'jonallured started watching'
        expect(hook.url).to eq 'https://github.com/jonallured'
      end
    end

    context 'issues' do
      context 'create' do
        it 'creates a Hook' do
          project = service.projects.create name: 'jonallured/cybertail-rails'

          params = {
            issue: {
              number: '1',
              title: 'Something is broken',
              html_url: 'https://github.com/jonallured/cybertail-ios/issues/1'
            },
            sender: { login: 'jonallured' },
            repository: { full_name: 'jonallured/cybertail-rails' }
          }

          headers = { 'X-GitHub-Event' => 'issues' }

          post "/v1/#{project.token}", params: params, headers: headers

          expect(Hook.count).to eq 1

          hook = Hook.first
          expect(hook.service_id).to eq service.id
          expected_message = 'jonallured opened #1: "Something is broken"'
          expect(hook.message).to eq expected_message
          expect(hook.url).to eq 'https://github.com/jonallured/cybertail-ios/issues/1'
        end
      end
    end

    context 'issue comments' do
      context 'create' do
        it 'creates a Hook' do
          project = service.projects.create name: 'jonallured/cybertail-rails'

          params = {
            comment: {
              html_url: 'https://github.com/jonallured/cybertail-rails/issues/1#issuecomment-123456'
            },
            issue: {
              number: '1',
              title: 'Something is broken'
            },
            sender: { login: 'jonallured' },
            repository: { full_name: 'jonallured/cybertail-rails' }
          }

          headers = { 'X-GitHub-Event' => 'issue_comment' }

          post "/v1/#{project.token}", params: params, headers: headers

          expect(Hook.count).to eq 1

          hook = Hook.first
          expect(hook.service_id).to eq service.id
          expected_message = 'jonallured commented on #1: "Something is broken"'
          expect(hook.message).to eq expected_message
          expect(hook.url).to eq 'https://github.com/jonallured/cybertail-rails/issues/1#issuecomment-123456'
        end
      end
    end
  end
end
