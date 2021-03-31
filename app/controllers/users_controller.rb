class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show; end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:message] = "Welcome #{user.email}!"
      redirect_to root_path
    else
      flash[:error] = 'Passwords do not match'
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
