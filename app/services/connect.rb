module Connect
  # def conn1(url)
  #   response = Faraday.get(
  #     "https://api.themoviedb.org/3/#{url}",
  #     api_key: Figaro.env.api_key,
  #     "language": "en-US"
  #   )
  #   JSON.parse(response.body, symbolize_names: true)
  # end
  
  # def conn2(url, param1 = nil, param2 = nil, 
  #   param3 = nil)
  #   response = Faraday.get(
  #     "https://api.themoviedb.org/3/#{url}",
  #     api_key: Figaro.env.api_key,
  #     "language": "en-US",
  #     "#{param1}": "#{param2}",
  #   )
  #   JSON.parse(response.body, symbolize_names: true)
  # end

  def conn
    Faraday.new(
      url: 'https://api.themoviedb.org',
      params: {
        'language': "en-US",
        'api_key': Figaro.env.api_key
      }
    )
  end

  # def conn3(url, param1 = nil, param2 = nil, 
  #   param3 = nil, param4 = nil, param5 = nil, param6 = nil)
  #   response = Faraday.get(
  #     "https://api.themoviedb.org/3/#{url}",
  #     api_key: Figaro.env.api_key,
  #     "language": "en-US",
  #     "#{param1}": "#{param2}",
  #     "#{param3}": "#{param4}",
  #     "#{param5}": "#{param6}"
  #   )
  #   JSON.parse(response.body, symbolize_names: true)
  # end
end