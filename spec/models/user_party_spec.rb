require 'rails_helper'

RSpec.describe UserParty, type: :model do
  describe "Relationships" do
    it { should belong_to :party }
    it { should belong_to :user }
  end

  describe "Class methods" do
    it "#invite_friends(arg1,arg2)" do
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
      friends = [[friend1.id, "invited"], [friend2.id, "invited"], [friend3.id, "invited"]]
      expected = UserParty.invite_friends(friends, party.id)
      expect(expected.length).to eq 3
    end
  end
end