class MovieService
  extend Connect
	def self.top_rated_movies
		data = []
		for page_num in (1..2) do
			response = conn2("movie/top_rated", "page", "#{page_num}")
			data += response[:results]
		end
    TopMovie.all_movies(data)
	end

	def self.matched_movies(text)
		data = []
		for page_num in (1..20) do
      parsed = conn3("search/movie", "query", "#{text}",
        "page", "#{page_num}", "include_adult", "false")
			data += parsed[:results]
		end
    MatchMovie.all_movies(data)
	end

	def self.forty_match_movies(text)
		matched_movies(text)[0..39]
	end

	def self.show_movie(api_id)
		ShowMovie.new(conn1("movie/#{api_id}"))
	end

	def self.reviews(api_id)
		reviews = []
		for page_num in (1..10) do
      parsed = conn2("movie/#{api_id}/reviews", "page", "#{page_num}")
			reviews += parsed[:results]
		end
		reviews
	end

  def self.cast(api_id)
    parsed = conn1("movie/#{api_id}/credits")
		parsed[:cast][0..9]
  end
end
