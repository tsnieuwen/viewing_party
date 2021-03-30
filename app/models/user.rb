class User < ApplicationRecord
  before_save :normalize_email, on: create
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password, confirmation: true

  has_many :user_parties, dependent: :destroy
  has_many :parties, through: :user_parties

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :messages, dependent: :destroy

  has_secure_password

  private

  def normalize_email
    self.email = email.downcase
  end
end
