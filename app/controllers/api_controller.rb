class ApiController < ApplicationController
  before_action :ensure_user

  private

  def current_user
    @current_user ||= User.find_by(token: request.headers['X-USER-TOKEN'])
  end

  def ensure_user
    head :not_found unless current_user
  end
end
