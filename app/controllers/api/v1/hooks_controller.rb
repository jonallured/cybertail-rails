class Api::V1::HooksController < ApplicationController
  before_action :ensure_user

  expose(:hooks) do
    if newest_hook_id = params[:newest_hook_id]
      Hook.newer_than_hook_for(current_user, newest_hook_id)
    else
      Hook.up_to_bookmark_for(current_user)
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(token: request.headers['X-USER-TOKEN'])
  end

  def ensure_user
    head :not_found unless current_user
  end
end
