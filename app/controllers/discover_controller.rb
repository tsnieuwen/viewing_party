class DiscoverController < ApplicationController
  before_action :authorized, only: [:index]

  def index
    @latest = MovieService.latest
  end
end
