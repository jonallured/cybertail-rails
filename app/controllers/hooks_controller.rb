class HooksController < ApplicationController
  protect_from_forgery with: :null_session

  expose(:hook)

  def create
    hook.save
    head :created
  end

  private

  def hook_params
    payload = JSON.parse(params[:payload])
    message = "Build ##{payload['number']} of #{payload['repository']['owner_name']}/#{payload['repository']['name']}@#{payload['branch']} by #{payload['author_name']} #{payload['result_message']}."
    url = payload['build_url']

    {
      payload: payload,
      message: message,
      url: url,
      sent_at: Time.now
    }
  end
end
