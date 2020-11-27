module Admin
  class RawHooksController < AdminController
    expose(:raw_hooks) { RawHook.order(:created_at).limit(10) }
  end
end
