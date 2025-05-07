class UsersController < ApplicationController
  def show
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path
  end
end
