class SessionsController < ApplicationController

  def new
  end

  def login
    user = User.find_by(email: params[:email].downcase)
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome #{user.email}!"
      redirect_to root_path
    else
      flash[:message] = "Incorrect Credentials"
      render :new
    end
  end

  def logout
    begin
      session[:user_id] = nil
      flash[:message] = "You have been logged out"
      redirect_to root_path
    rescue
      flash[:message] = "An unexpected error occured"
      redirect_to root_path
    end
  end
end