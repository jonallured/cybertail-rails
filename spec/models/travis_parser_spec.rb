require 'rails_helper'

describe TravisParser do
  describe '.parse' do
    let(:service) { FactoryGirl.create :travis_service }
    let(:project) { FactoryGirl.create :project, service: service }

    it 'creates a hook' do
      payload = {
        author_name: 'jonallured',
        build_url: 'https://travis-ci.org/jonallured/cybertail/builds/123',
        number: '1',
        result_message: 'passed',
      }

      TravisParser.parse({ payload: payload.to_json }, project)

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.project).to eq project
      expect(hook.message).to eq 'build #1 by jonallured passed'
      expect(hook.url).to eq 'https://travis-ci.org/jonallured/cybertail/builds/123'
    end
  end
end
