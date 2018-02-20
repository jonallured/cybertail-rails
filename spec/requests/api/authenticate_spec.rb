require 'rails_helper'

describe 'GET /v1/authenticate', subdomain: 'api' do
  context 'with invalid credentials' do
    it 'returns an empty 404 response' do
      params = { email: 'invalid@example.com', password: 'password' }

      get '/v1/authenticate.json', params: params

      expect(response.code).to eq '404'
      expect(response.body).to eq ''
    end
  end

  context 'with valid credentials' do
    it 'returns the token for that user' do
      user = FactoryBot.create :user
      params = { email: user.email, password: user.password }

      get '/v1/authenticate.json', params: params

      expect(response.code).to eq '200'

      response_json = JSON.parse response.body
      expect(response_json).to eq({
        'token' => user.token
      })
    end
  end
end
