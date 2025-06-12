class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Authentication
  helper_method :current_user

  allow_browser versions: :modern
  before_action :check_logged_in

  def check_logged_in
    return if current_user

    redirect_to root_path
  end
end
