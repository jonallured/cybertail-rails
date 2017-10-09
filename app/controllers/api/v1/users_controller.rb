class Api::V1::UsersController < ApplicationController
  before_action :ensure_user

  def update
    head :no_content if current_user.update(bookmarked_at: hook.created_at)
  end

  private

  def hook
    Hook.find params[:last_read_hook_id]
  end

  def current_user
    @current_user ||= User.find_by(token: request.headers['X-USER-TOKEN'])
  end

  def ensure_user
    head :not_found unless current_user
  end
end
