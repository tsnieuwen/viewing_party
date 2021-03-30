class FriendshipsController < ApplicationController
  before_action :find_friend, only: %i[new create]

  def new
    if @friend
      create
    else
      flash[:notice] = 'That user does not exist'
      redirect_to dashboard_path
    end
  end

  def create
    current_user.friends.push(@friend)
    flash[:notice] = "You have added #{@friend.email} as a friend!"
    redirect_to dashboard_path
  end

  private

  def find_friend
    @friend = User.find_by(email: params[:email])
  end
end
