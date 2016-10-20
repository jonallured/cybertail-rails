class TravisHooksController < ApplicationController
  protect_from_forgery with: :null_session

  expose(:hook)

  def create
    hook.save
    head :created
  end

  private

  def hook_params
    payload = JSON.parse(params[:payload])
    repository = payload['repository']
    project = [repository['owner_name'], repository['name']].join('/')
    message = "build ##{payload['number']} by #{payload['author_name']} #{payload['result_message'].downcase}"
    url = payload['build_url']

    {
      service: Service.travis,
      payload: payload,
      project: project,
      message: message,
      url: url,
      sent_at: Time.now
    }
  end
end
