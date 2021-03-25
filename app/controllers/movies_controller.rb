class MoviesController < ApplicationController
  before_action :populate_movie_record, only: [:show]

  def index
    @movies = MovieService.top_rated_movies
    # @movies = MovieService.forty_match_movies(params[:search])
    # @movies = MovieService.forty_match_movies("bond")
  end

  def show
    @movie = Movie.find_by(api_id: params[:id])
  end

  private

  def populate_movie_record
    if Movie.find_by(api_id: params[:id]) == nil
      Movie.create(api_id: params[:id])
    end
  end

end
