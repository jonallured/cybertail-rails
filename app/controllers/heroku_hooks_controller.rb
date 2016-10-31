class HerokuHooksController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    HerokuParser.parse(params)
    head :created
  end
end
