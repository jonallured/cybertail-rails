class Api::V1::HooksController < ApplicationController
  expose(:hooks) { Hook.where(suppress: false) }
end
