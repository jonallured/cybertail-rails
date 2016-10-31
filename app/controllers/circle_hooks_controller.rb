class CircleHooksController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    CircleParser.parse(params)
    head :created
  end
end
