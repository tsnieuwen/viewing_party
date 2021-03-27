class PartiesController < ApplicationController

  def new
    @movie = MovieService.show_movie(params[:api_id])
  end

  def create
    party = Party.create(party_params)
  end

  private

  def party_params
    params.permit(:duration, :movie_id, :host_id, 
      date_params(params["day(1i)"], params["day(2i)"],
      params["day(3i)"]),
      start_params(params[:hour], params[:minute],
      params[:am_pm]))
  end

  def date_params(year, month, day)
    date = Date::MONTHNAMES[month.to_i]
    "#{date} #{day}, #{year}"
  end

  def start_params(hour, minute, am_pm)
    expected = "#{hour}:#{minute} #{am_pm}"
  end
end
