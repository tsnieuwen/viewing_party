require 'faraday'
require 'json'
require './poro/movie'

class MovieService

	def self.movies
    total_results = []

    for page_num in (1..4) do
      url = "https://api.themoviedb.org/3/discover/movie?api_key=e15cc364b3eed6a09d12d9f9003b553c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=" + "#{page_num}"
      response = Faraday.get(url)
      parsed = JSON.parse(response.body, symbolize_names:true)
      total_results = total_results + parsed[:results]
    end
		movies = parsed.map do |data|
			Movie.new(data)
		end
		require "pry"; binding.pry
	end

  # def self.future_holidays
  #   future_holidays = holidays.find_all do |holiday|
  #     Date.today < holiday.date
  #   end
  # end
  #
  # def self.upcoming_holidays
  #   future_holidays[0..2]
  # end

end
puts MovieService.movies
