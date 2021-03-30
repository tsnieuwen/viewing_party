require 'rails_helper'

RSpec.describe PartyFacade do
  describe "Methods" do
    it "#make_parties(invited)" do
      UserParty.destroy_all
      User.destroy_all
      Party.destroy_all
      Movie.destroy_all

      @movie = Movie.create(api_id: "123")
      @friend1 = User.create(
        email: 'greatfriend@example.com',
        password: '1223'
      )
      @friend2 = User.create(
        email: 'bestestfriend@example.com',
        password: '4321'
      )
      @friend3 = User.create(
        email: 'friend3@example.com',
        password: 'test'
      )
      @user = User.create(
        email: 'foo@bar.com',
        password: 'test'
      )
      @party = @user.parties.create(
        date: Time.now,
        movie_id: @movie.id,
        duration: "321",
        host_id: @user.id,
        start_time: Time.now
      )
      @expected = {"#{@friend1.id}"=>"#{@friend1.id}", 
        "#{@friend2.id}"=>"#{@friend2.id}", "#{@friend3.id}"=>"false"}
      
      @parties = PartyFacade.make_parties(@expected, @user)

      expect(@parties).to be_an(Array)
      expect(@parties[0]).to be_an_instance_of(UserParty)
      expect(@parties.length).to eq 2
    end
  end
end