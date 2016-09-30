require 'rails_helper'

describe 'GitHub hooks' do
  it 'something' do
    github_service = Service.create name: 'GitHub'

    params = {
      repository: {
        full_name: 'jonallured/uplink-rails'
      }
    }

    headers = { 'X-GitHub-Event' => 'push' }

    post '/github_hooks', params: params, headers: headers

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service).to eq github_service
    expect(hook.project).to eq "jonallured/uplink-rails"
    expect(hook.message).to eq "Got event push, saved as Hook #{hook.id}."
    expect(hook.url).to eq "https://github.com"
  end
end
