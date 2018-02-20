require 'rails_helper'

describe CircleParser do
  describe '.parse' do
    let(:service) { FactoryBot.create :circle_service }
    let(:project) { FactoryBot.create :project, service: service }

    it 'creates a hook' do
      payload = {
        build_num: '1',
        build_url: 'https://circleci.com/gh/jonallured/test/20',
        committer_name: 'jonallured',
        outcome: 'success'
      }

      CircleParser.parse({ payload: payload }, project)

      expect(Hook.count).to eq 1

      hook = Hook.first
      expect(hook.project).to eq project
      expect(hook.message).to eq 'build #1 by jonallured passed'
      expect(hook.url).to eq 'https://circleci.com/gh/jonallured/test/20'
    end

    let(:payload) do
      {
        build_num: '1',
        build_url: 'https://circleci.com/gh/jonallured/test/20',
        committer_name: 'jonallured',
        outcome: outcome
      }
    end

    context 'with a canceled result' do
      let(:outcome) { 'canceled' }

      it 'creates a hook with a canceled result' do
        CircleParser.parse({ payload: payload }, project)

        hook = Hook.first
        expect(hook.message.split.last).to eq 'canceled'
      end
    end

    context 'with an infrastructure_fail result' do
      let(:outcome) { 'infrastructure_fail' }

      it 'creates a hook with a failed result' do
        CircleParser.parse({ payload: payload }, project)

        hook = Hook.first
        expect(hook.message.split.last).to eq 'failed'
      end
    end

    context 'with a timedout result' do
      let(:outcome) { 'timedout' }

      it 'creates a hook with a failed result' do
        CircleParser.parse({ payload: payload }, project)

        hook = Hook.first
        expect(hook.message.split.last).to eq 'failed'
      end
    end

    context 'with a failed result' do
      let(:outcome) { 'failed' }

      it 'creates a hook with a failed result' do
        CircleParser.parse({ payload: payload }, project)

        hook = Hook.first
        expect(hook.message.split.last).to eq 'failed'
      end
    end

    context 'with a no_tests result' do
      let(:outcome) { 'no_tests' }

      it 'creates a hook with a failed result' do
        CircleParser.parse({ payload: payload }, project)

        hook = Hook.first
        expect(hook.message.split.last).to eq 'failed'
      end
    end
  end
end
