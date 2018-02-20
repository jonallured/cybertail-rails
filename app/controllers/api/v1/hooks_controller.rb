class Api::V1::HooksController < ApiController
  expose(:hooks) do
    if (newest_hook_id = params[:newest_hook_id])
      Hook.newer_than_hook_for(current_user, newest_hook_id)
    else
      Hook.up_to_bookmark_for(current_user)
    end
  end
end
