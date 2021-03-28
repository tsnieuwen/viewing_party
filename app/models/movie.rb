class Movie < ApplicationRecord
  validates :api_id, presence: true
  has_many :parties

  def get_details
    MovieService.show_movie(self.api_id)
  end

  def self.consume_api
		movies = []
	  for page_num in (1..200) do
      url = "https://api.themoviedb.org/3/discover/movie?api_key=e15cc364b3eed6a09d12d9f9003b553c&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=#{page_num}"
      response = Faraday.get(url)
      parsed = JSON.parse(response.body, symbolize_names:true)
      movies = movies + parsed[:results]
    end
    movies
  end

  def self.populate
    consume_api.map do |data|
  	   Movie.create(api_id: data[:id])
    end
  end
end
