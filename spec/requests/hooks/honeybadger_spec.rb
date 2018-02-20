require 'rails_helper'

describe 'Honeybadger hooks', subdomain: 'hooks' do
  it 'something' do
    service = FactoryBot.create :honeybadger_service
    project = service.projects.create name: 'Cybertail'

    params = {
      project: {
        name: 'Cybertail'
      },
      fault: {
        klass: 'RuntimeError',
        message: 'Something went horribly wrong',
        url: 'https://app.honeybadger.io/projects/123/faults/456'
      }
    }

    post "/v1/#{project.token}", params: params

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service_id).to eq service.id
    expect(hook.message).to eq 'RuntimeError: Something went horribly wrong'
    expect(hook.url).to eq 'https://app.honeybadger.io/projects/123/faults/456'
  end
end
