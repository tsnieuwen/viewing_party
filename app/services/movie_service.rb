require 'faraday'
require 'json'
require 'figaro'
require './app/poro/top_movie'
require './app/poro/match_movie'

class MovieService

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

end
