class MoviesController < ApplicationController

  def index
    @top_movies = MovieService.top_rated_movies
    @forty_matches = MovieService.forty_match_movies(params[:search])
  end

end
