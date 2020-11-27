class RawHooksController < ApplicationController
  expose(:raw_hook) do
    attrs = HookRequest.to_attrs(request, params)
    RawHook.new(attrs)
  end

  def create
    if raw_hook.save
      head :created
    else
      head :unprocessable_entity
    end
  end
end
