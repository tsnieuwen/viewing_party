class MoviesController < ApplicationController
  before_action :populate_movie_record, only: [:show]
  before_action :authorized, only: [:index, :show]

  def index
    if params[:q] == 'top_rated'
      @movies = MovieFacade.top_rated_movies
    else
      @movies = MovieFacade.search(params[:search])
    end
  end

  def show
    @movie = Movie.find_by(api_id: params[:id])
    @movie_info = MovieFacade.show_movie(@movie.api_id)
    @details = MovieFacade.get_details(@movie.api_id)
    # @reviews = MovieFacade.reviews(@movie.api_id)
    # @cast = MovieService.cast(@movie.api_id)
  end

  private

  def populate_movie_record
    if Movie.find_by(api_id: params[:id]) == nil
      Movie.create(api_id: params[:id])
    end
  end
end
