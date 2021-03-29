require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
    UserParty.destroy_all
    User.destroy_all
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
  end

  describe 'When I visit a new viewing party page' do
    it 'I should see movie title, duration with default runtime in mins' do
      VCR.use_cassette('single_movie_details2') do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
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
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit movie_path("#{Figaro.env.movie_details}")
        click_button 'Create Viewing Party for The Lord of the Rings'

        expect(page).to have_xpath("//input[@min='132']")
      end
    end

    it 'Should redirect to the dashboard where new event is shown no friends' do
      VCR.use_cassette('single_movie_details3') do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
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
          expect(page).to have_content('April 20, 2021')
          expect(page).to have_content('4:30 PM')
          expect(page).to have_content('Hosting')
        end
      end
    end

    it 'Displays invited for friends that are invited' do
      VCR.use_cassette('single_movie_details5') do
        visit root_path
        click_link "I already have an account"
        fill_in :email, with: @user.email
        fill_in :password, with: "test"
        click_button "Log In"

        visit movie_path("#{Figaro.env.movie_details}")
        click_button 'Create Viewing Party for The Lord of the Rings'

        select('April', from: '_day_2i')
        select('2021', from: '_day_1i')
        select('20', from: '_day_3i')
        fill_in :hour, with: "4"
        fill_in :minute, with: "30"
        select('PM', from: 'am_pm')
        find(:xpath, "//input[@name=#{@friend1.id}]").set(true)
        find(:xpath, "//input[@name=#{@friend2.id}]").set(true)
        click_button('Create Party')

        expect(current_path).to eq(dashboard_path)

        within('.parties') do
          expect(page).to have_content('Hosting')
        end
        
        click_link "Log Out"
        click_link "I already have an account"
        fill_in :email, with: @friend1.email
        fill_in :password, with: "1223"
        click_button "Log In"
        visit dashboard_path
        
        within('.parties') do
          expect(page).to have_content('Invited')
        end

        click_link "Log Out"
        click_link "I already have an account"
        fill_in :email, with: @friend2.email
        fill_in :password, with: "4321"
        click_button "Log In"
        visit dashboard_path
        
        within('.parties') do
          expect(page).to have_content('Invited')
        end

        click_link "Log Out"
        click_link "I already have an account"
        fill_in :email, with: @friend3.email
        fill_in :password, with: "test"
        click_button "Log In"
        visit dashboard_path
        
        within('.parties') do
          expect(page).not_to have_content('Invited')
        end
      end
    end
  end
end