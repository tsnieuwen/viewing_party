module Connect
  def conn
    Faraday.new(
      url: 'http://api.themoviedb.org',
      params: {
        'language': 'en-US',
        'api_key': Figaro.env.api_key
      }
    )
  end
end
