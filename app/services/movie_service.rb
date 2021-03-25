require 'faraday'
require 'json'
require 'figaro'
require './app/poro/top_movie'

class MovieService

	# def self.populate_movie_table
  #   total_results = []
	#
  #   for page_num in (1..2) do
  #     url = "https://api.themoviedb.org/3/discover/movie?api_key=e15cc364b3eed6a09d12d9f9003b553c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=" + "#{page_num}"
  #     response = Faraday.get(url)
  #     parsed = JSON.parse(response.body, symbolize_names:true)
  #     total_results = total_results + parsed[:results]
  #   end
	#
			# 3/movie/top_rated
	# 	Movie.destroy_all!
	#
	# 	# movies = total_results.map do |data|
	# 	# 	Movie.new(data)
	# 	# end
	#
	# 	Movie.all_movies(data)
	# 	require "pry"; binding.pry
	# end

	# def self.top_rated_movies
	# 	 # url = "https://api.themoviedb.org/3/discover/movie?api_key=e15cc364b3eed6a09d12d9f9003b553c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=" + "#{page_num}"
	# 	 response = Faraday.get(
	# 		 "https://api.themoviedb.org/3/movie/top_rated",
	# 		 api_key: "e15cc364b3eed6a09d12d9f9003b553c"
	# 	 )
	# 	 parsed = JSON.parse(response.body, symbolize_names: true)
	# 	 require "pry"; binding.pry
	# end
	def self.top_rated_movies
		movies = []
	  for page_num in (1..2) do
      url = "https://api.themoviedb.org/3/movie/top_rated?api_key=e15cc364b3eed6a09d12d9f9003b553c&language=en-US&page=" + "#{page_num}"
      response = Faraday.get(url)
      parsed = JSON.parse(response.body, symbolize_names:true)
      movies = movies + parsed[:results]
    end
		top_movies = movies.map do |data|
			TopMovie.new(data)
		end
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
puts MovieService.top_rated_movies
