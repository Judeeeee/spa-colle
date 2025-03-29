class UsersController < ApplicationController
  def show
  end

  def destroy
    @user = current_user
    @user.checkin_logs.destroy_all # 外部キー制約対応は後で
    @user.destroy
    reset_session
    redirect_to root_path
  end
end
