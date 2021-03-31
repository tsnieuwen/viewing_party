class PartiesController < ApplicationController
  before_action :authorized, only: [:new]
  before_action :find_movie, only: [:create]

  def new
    @movie = MovieService.show_movie(params[:api_id])
  end

  def create
    party = current_user.parties.create!(
      date: date_params,
      movie_id: @movie.id,
      duration: params[:duration],
      host_id: current_user.id,
      start_time: start_params
    )
    PartyFacade.make_parties(params[:invited], party.id)
    redirect_to dashboard_path
  end

  private

  def date_params
    date = Date::MONTHNAMES[params['day(2i)'].to_i]
    "#{date} #{params['day(3i)']}, #{params['day(1i)']}"
  end

  def start_params
    "#{params[:hour]}:#{params[:minute]} #{params[:am_pm]}"
  end

  def find_movie
    @movie = Movie.find_by(api_id: params[:movie_id])
  end
end
