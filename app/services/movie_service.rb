class MovieService
  extend Connect
	def self.top_rated_movies
		data = []
		for page_num in (1..2) do
			response = conn.get("3/movie/top_rated") do |req|
        req.params['page'] = "#{page_num}"
      end
      attributes = JSON.parse(response.body, symbolize_names: true)
			data += attributes[:results]
		end
    TopMovie.all_movies(data)
	end

	def self.matched_movies(text)
		data = []
		for page_num in (1..2) do
      response = conn.get("3/search/movie",
        {
          'query': "#{text}",
          'page': "#{page_num}",
          'include_adult': 'false'
        })
      attributes = JSON.parse(response.body, symbolize_names: true)
			data += attributes[:results]
		end
    MatchMovie.all_movies(data)
	end

	def self.show_movie(api_id)
		response = conn.get("3/movie/#{api_id}")
    attributes = JSON.parse(response.body, symbolize_names: true)
    ShowMovie.new(attributes)
	end

	def self.reviews(api_id)
		reviews = []
		for page_num in (1..2) do
      response = conn.get("3/movie/#{api_id}/reviews") do |req|
        req.params['page'] = "#{page_num}"
      end
      attributes = JSON.parse(response.body, symbolize_names: true)
      reviews += attributes[:results]
		end
    cast = cast(api_id)
		{"all_reviews": reviews, "all_cast": cast}
	end

  def self.cast(api_id)
    response = conn.get("3/movie/#{api_id}/credits")
    attributes = JSON.parse(response.body, symbolize_names: true)
    full_cast = attributes[:cast].length
		attributes[:cast][0..full_cast]
  end
end