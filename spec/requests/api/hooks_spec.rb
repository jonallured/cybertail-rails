require 'rails_helper'

describe 'GET /v1/hooks' do
  context 'without a token' do
    it 'returns an empty 404 response' do
      hook = FactoryGirl.create :hook

      get '/v1/hooks.json'

      expect(response.code).to eq '404'
      expect(response.body).to eq ''
    end
  end

  context 'with an invalid token' do
    it 'returns an empty 404 response' do
      hook = FactoryGirl.create :hook

      get '/v1/hooks.json', params: { token: 'invalid' }

      expect(response.code).to eq '404'
      expect(response.body).to eq ''
    end
  end

  context 'with a valid token' do
    context 'with no subscriptions' do
      it 'returns an empty list of hooks' do
        FactoryGirl.create :hook
        user = FactoryGirl.create :user

        get '/v1/hooks.json', params: { token: user.token }

        expect(response.code).to eq '200'

        response_json = JSON.parse response.body
        expect(response_json).to eq([])
      end
    end

    context 'with a subscription' do
      it 'returns the hooks for that user' do
        hook = FactoryGirl.create :hook
        user = FactoryGirl.create :user
        FactoryGirl.create :subscription, user: user, project: hook.project

        get '/v1/hooks.json', params: { token: user.token }

        expect(response.code).to eq '200'

        response_json = JSON.parse response.body
        expect(response_json).to eq([
          {
            'service_id' => hook.project.service.id,
            'project_name' => hook.project.name,
            'message' => hook.message,
            'url' => hook.url,
            'sent_at' => hook.sent_at.as_json
          }
        ])
      end
    end
  end
end
