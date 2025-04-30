class SessionsController < ApplicationController
  skip_before_action :check_logged_in, only: [ :create, :failure ]

  def create
    if (user = User.find_or_create_from_auth_hash(auth_hash))
      log_in user
    end
    redirect_to root_path
  end

  def destroy
    log_out
    redirect_to root_path
  end

  def failure
    error_message = case params[:message]
    when "timeout"
                      "Google認証がタイムアウトしました。もう一度お試しください。"
    when "access_denied"
                      "Google認証が拒否されました。許可をお願いいたします。"
    when "invalid_credentials"
                      "Google認証に失敗しました。もう一度ログインしてください。"
    else
                      "Googleアカウント認証に失敗しました。"
    end

    flash[:alert] = error_message
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"] # https://github.com/zquestz/omniauth-google-oauth2?tab=readme-ov-file#auth-hash
  end
end
