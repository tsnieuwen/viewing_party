class MoviesController < ApplicationController
  before_action :populate_movie_record, only: [:show]
  before_action :authorized, only: %i[index show]

  def index
    @movies = if params[:q] == 'top_rated'
                MovieFacade.top_rated_movies
              else
                MovieFacade.search(params[:search])
              end
  end

  def show
    @movie = Movie.find_by(api_id: params[:id])
    @movie_info = MovieFacade.show_movie(@movie.api_id)
    @details = MovieFacade.movie_details(@movie.api_id)
  end

  private

  def populate_movie_record
    Movie.create(api_id: params[:id]) if Movie.find_by(api_id: params[:id]).nil?
  end
end
