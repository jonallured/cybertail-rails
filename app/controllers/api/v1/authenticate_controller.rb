class Api::V1::AuthenticateController < ApiController
  skip_before_action :ensure_user, only: :show

  expose(:user) { User.find_by email: params[:email] }

  def show
    head :not_found unless valid_user?
  end

  private

  def valid_user?
    user && user.valid_password?(params[:password])
  end
end
