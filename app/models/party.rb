class Party < ApplicationRecord
  validates :date, presence: true
  validates :duration, presence: true
  belongs_to :movie

  has_many :user_parties, dependent: :destroy
  has_many :users, through: :user_parties

  def find_host(host_id)
    users.find(host_id)
  end

  def invited
    users.where('users.id != ?', host_id)
  end
end
