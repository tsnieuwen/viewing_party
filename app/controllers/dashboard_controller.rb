class DashboardController < ApplicationController
  before_action :authorized, only: [:index]

  def index
    @parties = current_user.parties
  end
end