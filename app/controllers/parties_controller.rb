class PartiesController < ApplicationController

  def new
    @movie = MovieService.show_movie(params[:api_id])
  end

  def create
    # require "pry"; binding.pry
    movie = Movie.find_by(api_id: params[:movie_id])
    current_user.parties.create(
      date: date_params(params["day(1i)"], params["day(2i)"],
      params["day(3i)"]),
      movie_id: movie.id,
      duration: params[:duration],
      host_id: current_user.id,
      start_time: start_params(params[:hour], params[:minute],
      params[:am_pm])
    )

    redirect_to dashboard_path
    # redirect_to new_user_party_path({param1: params.to_enum.to_h,
    #   party_id: party.id})
  end

  private

  def date_params(year, month, day)
    date = Date::MONTHNAMES[month.to_i]
    "#{date} #{day}, #{year}"
  end

  def start_params(hour, minute, am_pm)
    "#{hour}:#{minute} #{am_pm}"
  end
end
