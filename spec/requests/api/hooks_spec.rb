require 'rails_helper'

describe 'GET /v1/hooks', subdomain: 'api' do
  context 'without a token' do
    it 'returns an empty 404 response' do
      get '/v1/hooks.json'

      expect(response.code).to eq '404'
      expect(response.body).to eq ''
    end
  end

  context 'with an invalid token' do
    it 'returns an empty 404 response' do
      get '/v1/hooks.json', headers: { 'X-USER-TOKEN' => 'invalid' }

      expect(response.code).to eq '404'
      expect(response.body).to eq ''
    end
  end

  context 'with a valid token' do
    context 'with no subscriptions' do
      it 'returns an empty list of hooks' do
        FactoryBot.create :hook
        user = FactoryBot.create :user

        get '/v1/hooks.json', headers: { 'X-USER-TOKEN' => user.token }

        expect(response.code).to eq '200'

        response_json = JSON.parse response.body
        expect(response_json).to eq([])
      end
    end

    context 'with a subscription' do
      it 'returns the hooks up to and including the bookmarked hook' do
        project = FactoryBot.create :project

        older_hook = FactoryBot.create(
          :hook,
          project: project,
          created_at: 1.day.ago
        )

        hook = FactoryBot.create :hook, project: project

        user = FactoryBot.create :user, bookmarked_at: hook.created_at
        FactoryBot.create :subscription, user: user, project: project

        get '/v1/hooks.json', headers: { 'X-USER-TOKEN' => user.token }

        expect(response.code).to eq '200'

        hooks = JSON.parse response.body

        expect(hooks.size).to eq 2
        expect(hooks).to eq(
          [
            {
              'id' => hook.id,
              'service_id' => hook.project.service.id,
              'project_name' => hook.project.name,
              'message' => hook.message,
              'url' => hook.url,
              'sent_at' => hook.sent_at.as_json
            },
            {
              'id' => older_hook.id,
              'service_id' => older_hook.project.service.id,
              'project_name' => older_hook.project.name,
              'message' => older_hook.message,
              'url' => older_hook.url,
              'sent_at' => older_hook.sent_at.as_json
            }
          ]
        )
      end

      context 'with a newest_hook_id' do
        it 'returns only hooks newer than that id' do
          project = FactoryBot.create :project

          hook = FactoryBot.create :hook, project: project

          newer_hook = FactoryBot.create(
            :hook,
            project: project,
            created_at: 1.day.from_now
          )

          user = FactoryBot.create :user, bookmarked_at: hook.created_at
          FactoryBot.create :subscription, user: user, project: project

          params = { newest_hook_id: hook.id }
          headers = { 'X-USER-TOKEN' => user.token }
          get '/v1/hooks.json', params: params, headers: headers

          hooks = JSON.parse response.body

          expect(hooks.size).to eq 1
          expect(hooks).to eq(
            [
              {
                'id' => newer_hook.id,
                'service_id' => newer_hook.project.service.id,
                'project_name' => newer_hook.project.name,
                'message' => newer_hook.message,
                'url' => newer_hook.url,
                'sent_at' => newer_hook.sent_at.as_json
              }
            ]
          )
        end
      end
    end
  end
end
