class Api::V1::AuthenticateController < ApplicationController
  expose(:user) { User.find_by email: params[:email] }

  def show
    head :not_found unless valid_user?
  end

  private

  def valid_user?
    user && user.valid_password?(params[:password])
  end
end
