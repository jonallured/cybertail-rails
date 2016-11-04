require 'rails_helper'

describe 'GET /v1/hooks' do
  context 'without a token' do
    it 'it returns an empty 404 response' do
      travis_service = Service.create name: 'Travis CI'
      hook = FactoryGirl.create :hook, service: travis_service

      get '/v1/hooks.json'

      expect(response.code).to eq '404'
      expect(response.body).to eq ''
    end
  end

  context 'with an invalid token' do
    it 'it returns an empty 404 response' do
      travis_service = Service.create name: 'Travis CI'
      hook = FactoryGirl.create :hook, service: travis_service

      get '/v1/hooks.json', params: { token: 'invalid' }

      expect(response.code).to eq '404'
      expect(response.body).to eq ''
    end
  end

  context 'with a valid token' do
    it 'something' do
      travis_service = Service.create name: 'Travis CI'
      hook = FactoryGirl.create :hook, service: travis_service
      user = FactoryGirl.create :user

      get '/v1/hooks.json', params: { token: user.token }

      expect(response.code).to eq '200'

      response_json = JSON.parse response.body
      expect(response_json).to eq([
        {
          'service_id' => travis_service.id,
          'project' => hook.project,
          'message' => hook.message,
          'url' => hook.url,
          'sent_at' => hook.sent_at.as_json
        }
      ])
    end
  end
end
