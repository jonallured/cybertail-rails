require 'rails_helper'

describe 'Travis hooks' do
  it 'something' do
    payload = {
      id: 1,
      number: "1",
      status: 0
    }

    params = {
      payload: payload.to_json
    }

    post '/hooks', params: params

    expect(Hook.count).to eq 1
  end
end
