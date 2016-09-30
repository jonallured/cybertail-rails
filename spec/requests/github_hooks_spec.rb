require 'rails_helper'

describe 'GitHub hooks' do
  it 'something' do
    github_service = Service.create name: 'GitHub'

    params = {
      key: "value"
    }

    post '/github_hooks', params: params

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service).to eq github_service
    expect(hook.message).to eq "Needs work"
    expect(hook.url).to eq "https://github.com"
  end
end
