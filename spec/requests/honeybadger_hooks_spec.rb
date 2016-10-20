require 'rails_helper'

describe 'Honeybadger hooks' do
  it 'something' do
    honeybadger_service = Service.create name: 'Honeybadger'

    params = {
      project: {
        name: 'Uplink'
      },
      fault: {
        klass: 'RuntimeError',
        message: 'Something went horribly wrong',
        url: "https://app.honeybadger.io/projects/123/faults/456"
      }
    }

    post '/honeybadger_hooks', params: params

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service).to eq honeybadger_service
    expect(hook.project).to eq "Uplink"
    expect(hook.message).to eq "RuntimeError: Something went horribly wrong"
    expect(hook.url).to eq "https://app.honeybadger.io/projects/123/faults/456"
  end
end
