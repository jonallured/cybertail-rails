class GithubHooksController < ApplicationController
  protect_from_forgery with: :null_session

  expose(:hook) { Hook.create hook_params }

  def create
    hook.save
    head :created
  end

  private

  def hook_params
    message = "Needs work"
    url = "https://github.com"

    {
      service: Service.github,
      payload: params.to_unsafe_hash,
      message: message,
      url: url,
      sent_at: Time.now
    }
  end
end
