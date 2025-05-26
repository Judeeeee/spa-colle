class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Authentication
  helper_method :current_user

  # コメントアウトしないとブラウザ検証ツールでデバイス操作ができない。https://bootcamp.fjord.jp/questions/1984
  # リリース前にはコメントアウトを外す
  # allow_browser versions: :modern
  before_action :check_logged_in

  def check_logged_in
    return if current_user

    redirect_to root_path
  end
end
