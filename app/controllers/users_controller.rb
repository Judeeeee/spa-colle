class UsersController < ApplicationController
  def show
    # showはturbo_streamのリクエスト専用。
    respond_to do |format|
      format.turbo_stream { render_user_modal }
      format.html { redirect_to root_path }
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path
  end

  private

  def render_user_modal
    render turbo_stream: turbo_stream.update(
      "user-modal-frame",
      partial: "users/user_modal",
    )
  end
end
