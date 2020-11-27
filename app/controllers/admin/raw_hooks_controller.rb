module Admin
  class RawHooksController < AdminController
    expose(:raw_hooks) { RawHook.order(created_at: :desc).limit(20) }
    expose(:raw_hook) { RawHook.find(params[:id]) }
  end
end
