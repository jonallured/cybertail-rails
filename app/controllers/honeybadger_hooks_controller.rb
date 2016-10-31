class HoneybadgerHooksController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    HoneybadgerParser.parse(params)
    head :created
  end
end
