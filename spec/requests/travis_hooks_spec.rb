require 'rails_helper'

describe 'Travis hooks' do
  it 'something' do
    travis_service = Service.create name: 'Travis CI'

    payload = {
      number: "1",
      branch: "master",
      author_name: 'Jon Allured',
      result_message: 'Passed',
      build_url: 'https://travis-ci.org/',
      repository: {
        owner_name: 'jonallured',
        name: 'uplink-rails'
      }
    }

    params = {
      payload: payload.to_json
    }

    post '/travis_hooks', params: params

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service).to eq travis_service
    expect(hook.project).to eq "jonallured/uplink-rails"
    expect(hook.message).to eq "build #1 by Jon Allured passed"
    expect(hook.url).to eq "https://travis-ci.org/"
  end
end
