require 'rails_helper'

describe HerokuParser do
  describe '.parse' do
    let(:service) { FactoryBot.create :heroku_service }
    let(:project) { FactoryBot.create :project, service: service }

    it 'creates a hook' do
      HerokuParser.parse({
        app: 'cybertail',
        release: 'v1',
        user: 'jonallured'
      }, project)

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.project).to eq project
      expect(hook.message).to eq 'v1 deployed by jonallured'
      expect(hook.url).to eq 'https://dashboard.heroku.com/apps/cybertail'
    end
  end
end
