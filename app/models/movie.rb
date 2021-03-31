class Movie < ApplicationRecord
  validates :api_id, presence: true
  has_many :parties, dependent: :destroy

  def details
    MovieService.show_movie(api_id)
  end

  def send_poster_info
    movie = MovieService.show_movie(api_id)
    "https://image.tmdb.org/t/p/w154#{movie.poster}"
  end
end
