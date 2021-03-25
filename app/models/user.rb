class User < ApplicationRecord
  before_save :normalize_email, on: create
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates_confirmation_of :password

  has_many :user_parties
  has_many :parties, through: :user_parties

  has_many :friendships
  has_many :friends, through: :friendships
  
  has_secure_password
  
  private

  def normalize_email
    self.email = email.downcase
  end
end