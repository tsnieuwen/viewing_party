class User < ApplicationRecord
  before_save :normalize_email, on: create
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  
  
  has_secure_password
  
  private

  def normalize_email
    self.email = email.downcase
  end
end