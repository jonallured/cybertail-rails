class HerokuHooksController < ApplicationController
  protect_from_forgery with: :null_session

  expose(:hook)

  def create
    hook.save
    head :created
  end

  private

  def hook_params
    project = params['app']
    message = "#{params['release']} deployed by #{params['user']}"
    url = "https://dashboard.heroku.com/apps/#{params['app']}"

    {
      service: Service.heroku,
      payload: params.to_unsafe_hash,
      project: project,
      message: message,
      url: url,
      sent_at: Time.now
    }
  end
end
