require 'rails_helper'

describe HoneybadgerParser do
  describe '.parse' do
    let(:service) { FactoryBot.create :honeybadger_service }
    let(:project) { FactoryBot.create :project, service: service }

    it 'creates a hook' do
      params = {
        fault: {
          klass: 'TerribleError',
          message: 'Everything is terrible!',
          url: 'https://app.honeybadger.io/projects/123/faults/456'
        }
      }
      HoneybadgerParser.parse(params, project)

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.project).to eq project
      expect(hook.message).to eq 'TerribleError: Everything is terrible!'
      expect(hook.url).to eq 'https://app.honeybadger.io/projects/123/faults/456'
    end
  end
end
