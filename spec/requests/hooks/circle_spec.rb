require 'rails_helper'

xdescribe 'Circle CI Hooks', subdomain: 'hooks' do
  let(:service) { FactoryBot.create :circle_service }

  let(:project) { service.projects.create name: 'jonallured/cybertail-rails' }

  let(:payload) do
    {
      build_num: '1',
      committer_name: 'Jon Allured',
      outcome: outcome,
      build_url: 'https://circleci.com/',
      username: 'jonallured',
      reponame: 'cybertail-rails'
    }
  end

  let(:params) { { payload: payload } }

  context 'with an outcome of "canceled"' do
    let(:outcome) { 'canceled' }
    it 'creates a hook with a cancelled message' do
      post "/v1/#{project.token}", params: params

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq 'build #1 by Jon Allured canceled'
      expect(hook.url).to eq 'https://circleci.com/'
    end
  end

  context 'with an outcome of "infrastructure_fail"' do
    let(:outcome) { 'infrastructure_fail' }
    it 'creates a hook with a failed message' do
      post "/v1/#{project.token}", params: params

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq 'build #1 by Jon Allured failed'
      expect(hook.url).to eq 'https://circleci.com/'
    end
  end

  context 'with an outcome of "timedout"' do
    let(:outcome) { 'timedout' }
    it 'creates a hook with a failed message' do
      post "/v1/#{project.token}", params: params

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq 'build #1 by Jon Allured failed'
      expect(hook.url).to eq 'https://circleci.com/'
    end
  end

  context 'with an outcome of "failed"' do
    let(:outcome) { 'failed' }
    it 'creates a hook with a failed message' do
      post "/v1/#{project.token}", params: params

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq 'build #1 by Jon Allured failed'
      expect(hook.url).to eq 'https://circleci.com/'
    end
  end

  context 'with an outcome of "no_tests"' do
    let(:outcome) { 'no_tests' }
    it 'creates a hook with a failed message' do
      post "/v1/#{project.token}", params: params

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq 'build #1 by Jon Allured failed'
      expect(hook.url).to eq 'https://circleci.com/'
    end
  end

  context 'with an outcome of "success"' do
    let(:outcome) { 'success' }
    it 'creates a hook with a failed message' do
      post "/v1/#{project.token}", params: params

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.service_id).to eq service.id
      expect(hook.message).to eq 'build #1 by Jon Allured passed'
      expect(hook.url).to eq 'https://circleci.com/'
    end
  end
end
