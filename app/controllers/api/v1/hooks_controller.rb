class Api::V1::HooksController < ApplicationController
  expose(:hooks) { Hook.all }
end
