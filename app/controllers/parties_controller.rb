class PartiesController < ApplicationController

  def new
    @movie = MovieService.show_movie(params[:api_id])
  end

end