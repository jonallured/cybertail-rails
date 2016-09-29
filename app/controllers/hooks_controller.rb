class HooksController < ApplicationController
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
