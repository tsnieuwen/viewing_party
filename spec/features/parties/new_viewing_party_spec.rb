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
    @user.friends << @friend1
    @user.friends << @friend2
    @user.friends << @friend3
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When I visit a new viewing party page' do
    it 'I should see movie title, duration with default runtime in mins' do
      VCR.use_cassette('single_movie_details2') do
        visit movie_path("#{Figaro.env.movie_details}")
        click_button 'Create Viewing Party for The Lord of the Rings'
        
        expect(page).to have_content('Movie Title: The Lord of the Rings')
        expect(page).to have_field('duration', with: 132)
        expect(page).to have_field('_day_1i')
        expect(page).to have_field('am_pm')
        expect(page).to have_field :minute
        expect(page).to have_field :hour
      end
    end

    it 'Party should not be created if duration less than that of movie' do 
      VCR.use_cassette('single_movie_details2') do
        visit movie_path("#{Figaro.env.movie_details}")
        click_button 'Create Viewing Party for The Lord of the Rings'
        
        expect(page).to have_xpath("//input[@min='132']")
      end
    end

    it 'Should redirect to the dashboard where new event is shown' do
      VCR.use_cassette('single_movie_details2') do
        visit movie_path("#{Figaro.env.movie_details}")
        click_button 'Create Viewing Party for The Lord of the Rings'

        select('April', from: '_day_2i')
        select('2021', from: '_day_1i')
        select('20', from: '_day_3i')
        fill_in :hour, with: "4"
        fill_in :minute, with: "30"
        select('PM', from: 'am_pm')
        click_button('Create Party')

        expect(current_path).to eq(dashboard_path)

        within('.parties') do
          expect(page).to have_content('The Lord of the Rings')
          expect(page).to have_content('April 20 2021')
          expect(page).to have_content('4:30 PM')
          expect(page).to have_content('Hosting')
        end
      end
    end

    it 'Friends should be able to log in and see event'
    it 'Cant create party in the past'
  end
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