class Api::V1::UsersController < ApiController
  def update
    head :no_content if current_user.update(bookmarked_at: hook.created_at)
  end

  private

  def hook
    Hook.find params[:last_read_hook_id]
  end
end
