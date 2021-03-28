class Movie < ApplicationRecord
  validates :api_id, presence: true
  has_many :parties

  def get_details
    MovieService.show_movie(self.api_id)
  end
end
