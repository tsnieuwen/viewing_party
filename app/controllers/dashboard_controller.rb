class DashboardController < ApplicationController
  before_action :authorized, only: [:index]

  def index
  end
end