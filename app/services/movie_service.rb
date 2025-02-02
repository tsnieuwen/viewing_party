class MovieService
  extend Connect
  def self.top_rated_movies
    data = []
    (1..2).each do |page_num|
      response = conn.get('3/movie/top_rated') do |req|
        req.params['page'] = page_num.to_s
      end
      attributes = JSON.parse(response.body, symbolize_names: true)
      data += attributes[:results]
    end
    TopMovie.all_movies(data)
  end

  def self.matched_movies(text)
    data = []
    (1..2).each do |page_num|
      response = conn.get('3/search/movie',
                          { 'query': text.to_s, 'page': page_num.to_s, 'include_adult': 'false' })
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
    (1..2).each do |page_num|
      response = conn.get("3/movie/#{api_id}/reviews") do |req|
        req.params['page'] = page_num.to_s
      end
      attributes = JSON.parse(response.body, symbolize_names: true)
      reviews += attributes[:results]
    end
    cast = cast(api_id)
    { "all_reviews": reviews, "all_cast": cast }
  end

  def self.cast(api_id)
    response = conn.get("3/movie/#{api_id}/credits")
    attributes = JSON.parse(response.body, symbolize_names: true)
    cast = attributes[:cast].length
    cast = 9 if cast > 10
    attributes[:cast][0..cast]
  end

  def self.keywords(api_id)
    response = conn.get("3/movie/#{api_id}/keywords")
    attributes = JSON.parse(response.body, symbolize_names: true)
    attributes[:keywords].map do |key|
      key[:name].titleize
    end
  end

  def self.latest
    response = conn.get('3/movie/latest')
    attributes = JSON.parse(response.body, symbolize_names: true)
    ShowMovie.new(attributes)
  end
end
