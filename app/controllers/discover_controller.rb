class DiscoverController < ApplicationController
  before_action :authorized, only: [:index]

  def index; end
end
