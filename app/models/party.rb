class Party < ApplicationRecord
  validates :date, presence: true
  validates :duration, presence: true
  belongs_to :movie
end