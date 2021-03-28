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

  describe "Instance Methods" do
    it "#find_host(arg)" do
      UserParty.destroy_all 
      Party.destroy_all
      Movie.destroy_all
      User.destroy_all
      movie = Movie.create(
        api_id: "123"
      )
      friend1 = User.create(
        email: 'greatfriend@example.com',
        password: '1223'
      )
      friend2 = User.create(
        email: 'bestestfriend@example.com',
        password: '4321'
      )
      friend3 = User.create(
        email: 'friend3@example.com',
        password: 'test'
      )
      user = User.create(
        email: 'foo@bar.com',
        password: 'test'
      )
      party = user.parties.create(
        date: "10/10/2020",
        movie_id: movie.id,
        duration: "123",
        host_id: user.id,
        start_time: "123"
      )
      party.users << [friend1, friend2, friend3]
      expect(party.find_host(user.id).email).to eq(user.email)
    end

    it "#invited" do
      UserParty.destroy_all 
      Party.destroy_all
      Movie.destroy_all
      User.destroy_all
      movie = Movie.create(
        api_id: "123"
      )
      friend1 = User.create(
        email: 'greatfriend@example.com',
        password: '1223'
      )
      friend2 = User.create(
        email: 'bestestfriend@example.com',
        password: '4321'
      )
      friend3 = User.create(
        email: 'friend3@example.com',
        password: 'test'
      )
      user = User.create(
        email: 'foo@bar.com',
        password: 'test'
      )
      party = user.parties.create(
        date: "10/10/2020",
        movie_id: movie.id,
        duration: "123",
        host_id: user.id,
        start_time: "123"
      )
      party.users << [friend1, friend2, friend3]
      expect(party.invited.length).to eq 3
    end
  end
end