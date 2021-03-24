class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :authorized, :logged_in

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
    end
  end

  def authorized
    redirect_to login_path if logged_in == false
  end

  def logged_in
    !!current_user
  end
end
