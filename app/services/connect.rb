module Connect
  def conn
    Faraday.new(
      url: 'https://api.themoviedb.org',
      params: {
        'language': "en-US",
        'api_key': Figaro.env.api_key
      }
    )
  end
end