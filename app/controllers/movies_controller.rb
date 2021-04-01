class MoviesController < ApplicationController
  before_action :populate_movie_record, only: [:show]
  before_action :authorized, only: %i[index show]

  def index
    @movies = if params[:q] == 'top_rated'
                MovieFacade.top_rated_movies
              else
                MovieFacade.search(params[:search])
              end
    return unless @movies.nil?

    flash[:notice] = 'An error occured, please try again'
    redirect_to discover_index_path
  end

  def show
    @movie = Movie.find_by(api_id: params[:id])
    @movie_info = MovieFacade.show_movie(@movie.api_id)
    @details = MovieFacade.movie_details(@movie.api_id)
    @keywords = MovieFacade.keywords(@movie.api_id)
    return unless @movie.nil? || @movie_info.nil?

    flash[:notice] = 'An error occured, please try again'
    redirect_to discover_index_path
  end

  private

  def populate_movie_record
    Movie.create(api_id: params[:id]) if Movie.find_by(api_id: params[:id]).nil?
  end
end
