class HooksController < ApplicationController
  protect_from_forgery with: :null_session

  expose(:hook)

  def create
    hook.save
    head :created
  end

  private

  def hook_params
    {
      payload: JSON.parse(params[:payload]),
      sent_at: Time.now
    }
  end
end
