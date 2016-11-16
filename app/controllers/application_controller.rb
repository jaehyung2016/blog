class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def admin?
    current_user && current_user.is_admin
  end

  def require_login
    unless logged_in?
      redirect_back(fallback_location: root_path)
    end
  end
end
