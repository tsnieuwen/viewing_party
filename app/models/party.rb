class Party < ApplicationRecord
  validates :date, presence: true
  validates :duration, presence: true
  belongs_to :movie

  has_many :user_parties
  has_many :users, through: :user_parties
end