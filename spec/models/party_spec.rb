require 'rails_helper'

RSpec.describe Party, type: :model do
  describe "Validations" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :duration }
  end

  describe "Relationships" do
    it { should belong_to :movie }
    it { should have_many :user_parties }
    it { should have_many(:users).through(:user_parties) }
  end
end