require 'rails_helper'

describe 'GET /v1/users', subdomain: 'api' do
  context 'without a token' do
    it 'returns an empty 404 response' do
      user = FactoryBot.create :user
      hook = FactoryBot.create :hook

      params = { latest_hook_id: hook.id }
      patch '/v1/users', params: params, as: :json

      expect(response.code).to eq '404'
      expect(response.body).to eq ''
    end
  end

  context 'with an invalid token' do
    it 'returns an empty 404 response' do
      user = FactoryBot.create :user
      hook = FactoryBot.create :hook

      params = { latest_hook_id: hook.id }
      patch '/v1/users', params: params, headers: { 'X-USER-TOKEN' => 'invalid' }, as: :json

      expect(response.code).to eq '404'
      expect(response.body).to eq ''
    end
  end

  context 'with a valid token' do
    it 'updates the user' do
      old_hook = FactoryBot.create :hook, created_at: 1.day.ago
      new_hook = FactoryBot.create :hook, created_at: 1.hour.ago

      user = FactoryBot.create :user, bookmarked_at: old_hook.created_at

      params = { latest_hook_id: new_hook.id }
      patch '/v1/users', params: params, headers: { 'X-USER-TOKEN' => user.token }, as: :json

      expect(response.code).to eq '204'
      expect(response.body).to eq ''

      expect(User.first.bookmarked_at.to_i).to eq new_hook.created_at.to_i
    end
  end
end
