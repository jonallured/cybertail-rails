require 'rails_helper'

describe HerokuParser do
  describe '.parse' do
    context 'without an existing project' do
      it 'creates a new project and add a new hook to it' do
        Service.create name: 'Heroku'

        params = {
          app: 'cybertail-rails'
        }
        HerokuParser.parse(params)

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
        service = Service.create name: 'Heroku'
        project = service.projects.create name: 'cybertail-rails'

        params = {
          app: project.name
        }
        HerokuParser.parse(params)

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
