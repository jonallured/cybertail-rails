require 'rails_helper'

describe HoneybadgerParser do
  describe '.parse' do
    context 'without an existing project' do
      it 'creates a new project and add a new hook to it' do
        Service.create name: 'Honeybadger'

        params = {
          project: { name: 'cybertail-rails' },
          fault: {}
        }
        HoneybadgerParser.parse(params)

        expect(Hook.count).to eq 1
        expect(Project.count).to eq 1

        hook = Hook.first
        project = Project.first
        expect(hook.project).to eq project
        expect(project.name).to eq 'cybertail-rails'
      end
    end

    context 'with an existing project' do
      it 'creates a hook for that project' do
        service = Service.create name: 'Honeybadger'
        project = service.projects.create name: 'cybertail-rails'

        params = {
          project: { name: 'cybertail-rails' },
          fault: {}
        }
        HoneybadgerParser.parse(params)

        expect(Hook.count).to eq 1
        expect(Project.count).to eq 1

        hook = Hook.first
        project = Project.first
        expect(hook.project).to eq project
        expect(project.name).to eq 'cybertail-rails'
      end
    end
  end
end
