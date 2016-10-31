require 'rails_helper'

describe 'Circle CI Hooks' do
  it 'something' do
    circle_service = Service.create name: 'Circle CI'

    payload = {
      build_num: "1",
      committer_name: 'Jon Allured',
      outcome: 'Passed',
      build_url: 'https://circleci.com/',
      username: 'jonallured',
      reponame: 'uplink-rails'
    }

    params = {
      payload: payload.to_json
    }

    post '/circle_hooks', params: params

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service).to eq circle_service
    expect(hook.project).to eq "jonallured/uplink-rails"
    expect(hook.message).to eq "build #1 by Jon Allured passed"
    expect(hook.url).to eq "https://circleci.com/"
  end
end
