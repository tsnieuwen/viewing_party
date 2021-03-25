class Movie < ApplicationRecord
  validates :api_id, presence: true
  has_many :parties
end
