require 'rails_helper'

describe 'GitHub hooks' do
  it 'something' do
    github_service = Service.create name: 'GitHub'

    params = {
      repository: {
        full_name: 'jonallured/uplink-rails'
      }
    }

    headers = { 'X-GitHub-Event' => 'ping' }

    post '/github_hooks', params: params, headers: headers

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service).to eq github_service
    expect(hook.project).to eq "jonallured/uplink-rails"
    expect(hook.message).to eq "Got event ping, saved as Hook #{hook.id}."
    expect(hook.url).to eq "https://github.com"
  end

  context 'delete event' do
    it 'something' do
      github_service = Service.create name: 'GitHub'

      params = {
        sender: { login: 'jonallured' },
        ref: 'tmp',
        ref_type: 'branch',
        repository: {
          full_name: 'jonallured/uplink-rails',
          html_url: 'https://github.com/jonallured/uplink-rails/'
        }
      }

      headers = { 'X-GitHub-Event' => 'delete' }

      post '/github_hooks', params: params, headers: headers

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.service).to eq github_service
      expect(hook.project).to eq 'jonallured/uplink-rails'
      expect(hook.message).to eq 'jonallured deleted branch "tmp"'
      expect(hook.url).to eq 'https://github.com/jonallured/uplink-rails/'
    end
  end

  context 'push event' do
    context 'with some commits' do
      it 'creates a GitHub push Hook' do
        github_service = Service.create name: 'GitHub'

        params = {
          commits: [ 'a', 'b' ],
          compare: "https://github.com/jonallured/uplink-rails/compare/sha1...sha2",
          pusher: { name: 'jonallured' },
          ref: 'refs/heads/master',
          repository: { full_name: 'jonallured/uplink-rails' }
        }

        headers = { 'X-GitHub-Event' => 'push' }

        post '/github_hooks', params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook.service).to eq github_service
        expect(hook.project).to eq "jonallured/uplink-rails"
        expect(hook.message).to eq "jonallured pushed 2 commits to master"
        expect(hook.url).to eq "https://github.com/jonallured/uplink-rails/compare/sha1...sha2"
      end
    end
  end

  context 'travis status event' do
    context 'travis push' do
      it 'creates a suppressed GitHub travis Hook' do
        github_service = Service.create name: 'GitHub'

        params = {
          context: 'continuous-integration/travis-ci/push',
          repository: { full_name: 'jonallured/uplink-rails' }
        }

        headers = { 'X-GitHub-Event' => 'status' }

        post '/github_hooks', params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook).to be_suppress
        expect(hook.service).to eq github_service
        expect(hook.project).to eq 'jonallured/uplink-rails'
        expect(hook.message).to eq nil
        expect(hook.url).to eq nil
      end
    end

    context 'travis pr' do
      it 'creates a suppressed GitHub travis Hook' do
        github_service = Service.create name: 'GitHub'

        params = {
          context: 'continuous-integration/travis-ci/pr',
          repository: { full_name: 'jonallured/uplink-rails' }
        }

        headers = { 'X-GitHub-Event' => 'status' }

        post '/github_hooks', params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook).to be_suppress
        expect(hook.service).to eq github_service
        expect(hook.project).to eq 'jonallured/uplink-rails'
        expect(hook.message).to eq nil
        expect(hook.url).to eq nil
      end
    end

    context 'with some commits' do
      it 'creates a GitHub push Hook' do
        github_service = Service.create name: 'GitHub'

        params = {
          commits: [ 'a', 'b' ],
          compare: "https://github.com/jonallured/uplink-rails/compare/sha1...sha2",
          pusher: { name: 'jonallured' },
          ref: 'refs/heads/master',
          repository: { full_name: 'jonallured/uplink-rails' }
        }

        headers = { 'X-GitHub-Event' => 'push' }

        post '/github_hooks', params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook.service).to eq github_service
        expect(hook.project).to eq "jonallured/uplink-rails"
        expect(hook.message).to eq "jonallured pushed 2 commits to master"
        expect(hook.url).to eq "https://github.com/jonallured/uplink-rails/compare/sha1...sha2"
      end
    end
  end
end
