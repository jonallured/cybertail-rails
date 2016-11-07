require 'rails_helper'

describe TravisParser do
  describe '.parse' do
    context 'without an existing project' do
      it 'creates a new project and add a new hook to it' do
        Service.create name: 'Travis CI'

        payload = {
          repository: {
            owner_name: 'jonallured',
            name: 'uplink-rails'
          },
          result_message: 'passed'
        }
        TravisParser.parse({ payload: payload.to_json })

        expect(Hook.count).to eq 1
        expect(Project.count).to eq 1

        hook = Hook.first
        project = Project.first
        expect(hook.project).to eq project
        expect(project.name).to eq 'jonallured/uplink-rails'
      end
    end

    context 'with an existing project' do
      it 'creates a hook for that project' do
        service = Service.create name: 'Travis CI'
        project = service.projects.create name: 'jonallured/uplink-rails'

        payload = {
          repository: {
            owner_name: 'jonallured',
            name: 'uplink-rails'
          },
          result_message: 'passed'
        }
        TravisParser.parse({ payload: payload.to_json })

        expect(Hook.count).to eq 1
        expect(Project.count).to eq 1

        hook = Hook.first
        project = Project.first
        expect(hook.project).to eq project
        expect(project.name).to eq 'jonallured/uplink-rails'
      end
    end
  end
end
