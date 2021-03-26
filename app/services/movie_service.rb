require 'faraday'
require 'json'
require 'figaro'
require './app/poro/top_movie'
require './app/poro/match_movie'
require './app/poro/show_movie'

class MovieService

	def self.top_rated_movies
		movies = []
	  for page_num in (1..2) do
      url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Figaro.env.api_key}&language=en-US&page=" + "#{page_num}"
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
			url = "https://api.themoviedb.org/3/search/movie?api_key=#{Figaro.env.api_key}&language=en-US&query=#{text}&page=#{page_num}&include_adult=false"
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

	def self.show_movie(api_id)
		response = Faraday.get("https://api.themoviedb.org/3/movie/#{api_id}?api_key=#{Figaro.env.api_key}&language=en-US")
		parsed = JSON.parse(response.body, symbolize_names:true)
		ShowMovie.new(parsed)
	end

	def self.reviews(api_id)
		reviews = []
		for page_num in (1..10) do
			url = ("https://api.themoviedb.org/3/movie/#{api_id}/reviews?api_key=#{Figaro.env.api_key}&language=en-US&page=#{page_num}")
			response = Faraday.get(url)
			parsed = JSON.parse(response.body, symbolize_names:true)
			reviews = reviews + parsed[:results]
		end
		reviews
	end

	def self.cast(api_id)
		response = Faraday.get("https://api.themoviedb.org/3/movie/#{api_id}/credits?api_key=#{Figaro.env.api_key}&language=en-U")
		parsed = JSON.parse(response.body, symbolize_names:true)
		parsed[:cast][0..9]
	end

end
