class PartiesController < ApplicationController
before_action :authorized, only: [:new]

  def new
    @movie = MovieService.show_movie(params[:api_id])
  end

  def create
    movie = Movie.find_by(api_id: params[:movie_id])
    party = current_user.parties.create!(
      date: date_params(params["day(1i)"], params["day(2i)"],
      params["day(3i)"]),
      movie_id: movie.id,
      duration: params[:duration],
      host_id: current_user.id,
      start_time: start_params(params[:hour], params[:minute],
        params[:am_pm])
      )
    require 'pry'; binding.pry
    PartyFacade.make_parties(params[:invited])
    
    invited = params.to_enum.to_h.find_all do |key, value|
       key if value == "invited"
    end
    UserParty.invite_friends(invited, party.id)
    redirect_to dashboard_path
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
