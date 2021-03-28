class Movie < ApplicationRecord
  validates :api_id, presence: true
  has_many :parties

  def get_details
    MovieService.show_movie(self.api_id)
  end
  
  def send_poster_info
    movie = MovieService.show_movie(self.api_id)
    "https://image.tmdb.org/t/p/w500#{movie.poster}"
  end
end
