class UsersController < ApplicationController
  def display_delete_user_modal
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path
  end
end
