class SessionsController < ApplicationController
  skip_before_action :check_logged_in, only: [ :create, :failure ]

  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    log_in(user) if user
    redirect_to root_path
  end

  def destroy
    log_out
    redirect_to root_path
  end

  def failure
    flash[:alert] = failure_error_message(params[:message])
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"] # https://github.com/zquestz/omniauth-google-oauth2?tab=readme-ov-file#auth-hash
  end

  def failure_error_message(message)
    error_messages = {
      "timeout" => "Google認証がタイムアウトしました。もう一度お試しください。",
      "access_denied" => "Google認証が拒否されました。許可をお願いいたします。",
      "invalid_credentials" => "Google認証に失敗しました。もう一度ログインしてください。"
    }

    error_messages[message] || "Googleアカウント認証に失敗しました。"
  end
end
