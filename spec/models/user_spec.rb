require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe "Relationships" do
    it { should have_many :user_parties }
    it { should have_many(:parties).through(:user_parties) }

    it { should have_many :friendships }
    it { should have_many(:friends).through(:friendships) }

    it { should have_many :messages }
  end

  describe "Callbacks" do
    it "Cleans email to lowercase" do
      user = User.create(email: 'GREAT@example.com', password: '1234')
      expect(user.email).to eq('great@example.com')
    end
  end
end