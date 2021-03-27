require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When I visit a new viewing party page' do
    it 'I should see movie title, duration with default runtime in mins'
    it 'Party should not be created if duration less than that of movie' 
    it 'Should redirect to the dashboard where new event is shown'
    it 'Friends should be able to log in and see event'
end

# As an authenticated user,
# When I visit the new viewing party page,
# I should see the name of the movie title 
# rendered above a form with the following fields:

#  Duration of Party with a default value of 
#  movie runtime in minutes; a viewing party should 
#  NOT be created if set to a value less than the duration of the movie
#  When: field to select date
#  Start Time: field to select time
#  Checkboxes next to each friend 
#  (if user has friends)
#  Button to create a party
# Details When the party is created, 
# the authenticated user should be redirected back to 
# the dashboard where the new event is shown. The event 
# should also be seen by any friends that were invited when they log in.