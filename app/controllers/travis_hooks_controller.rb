class TravisHooksController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    TravisParser.parse(params)
    head :created
  end
end
