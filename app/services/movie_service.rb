require 'faraday'
require 'json'
require 'figaro'
require './app/poro/top_movie'
require './app/poro/match_movie'

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

	def self.matched_movies(text)
		movies = []
		for page_num in (1..20) do
			url = "https://api.themoviedb.org/3/search/movie?api_key=e15cc364b3eed6a09d12d9f9003b553c&language=en-US&query=#{text}&page=#{page_num}&include_adult=false"
			response = Faraday.get(url)
			parsed = JSON.parse(response.body, symbolize_names:true)
			movies = movies + parsed[:results]
		end
		matched_movies = movies.map do |data|
			MatchMovie.new(data)
		end
	end

	def self.forty_match_movies(text)
		matched_movies(text)[0..39]
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
