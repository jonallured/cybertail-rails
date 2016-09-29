require 'rails_helper'

describe 'GET /v1/hooks' do
  it 'something' do
    travis_service = Service.create name: 'Travis CI'
    hook = FactoryGirl.create :hook, service: travis_service

    get '/v1/hooks.json'

    expect(response.code).to eq '200'

    response_json = JSON.parse response.body
    expect(response_json).to eq([
      {
        'service_id' => travis_service.id,
        'message' => hook.message,
        'url' => hook.url,
        'sent_at' => hook.sent_at.as_json
      }
    ])
  end
end
