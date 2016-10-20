class HoneybadgerHooksController < ApplicationController
  protect_from_forgery with: :null_session

  expose(:hook)

  def create
    hook.save
    head :created
  end

  private

  def hook_params
    payload = params
    project = payload['project']['name']
    fault = payload['fault']
    message = "#{fault['klass']}: #{fault['message']}"
    url = fault['url']

    {
      service: Service.honeybadger,
      payload: payload,
      project: project,
      message: message,
      url: url,
      sent_at: Time.now
    }
  end
end
