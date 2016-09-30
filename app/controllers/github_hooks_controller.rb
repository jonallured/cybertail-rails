class GithubHooksController < ApplicationController
  protect_from_forgery with: :null_session

  expose(:hook) { Hook.create hook_params }

  def create
    hook.save
    event = request.headers['X-GitHub-Event']
    hook.update_attributes message: "Got event #{event}, saved as Hook #{hook.id}."
    head :created
  end

  private

  def hook_params
    url = "https://github.com"

    {
      service: Service.github,
      payload: params.to_unsafe_hash,
      url: url,
      sent_at: Time.now
    }
  end
end
