require 'rails_helper'

describe 'Travis hooks', subdomain: 'hooks' do
  it 'something' do
    service = FactoryBot.create :travis_service
    project = service.projects.create name: 'jonallured/cybertail-rails'

    payload = {
      number: "1",
      author_name: 'Jon Allured',
      result_message: 'Passed',
      build_url: 'https://travis-ci.org/',
      repository: {
        owner_name: 'jonallured',
        name: 'cybertail-rails'
      }
    }

    params = {
      payload: payload.to_json
    }

    post "/v1/#{project.token}", params: params

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service_id).to eq service.id
    expect(hook.message).to eq "build #1 by Jon Allured passed"
    expect(hook.url).to eq "https://travis-ci.org/"
  end
end
