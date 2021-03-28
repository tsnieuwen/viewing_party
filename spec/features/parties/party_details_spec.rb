require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
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

  describe 'When Im on my dashboard and hosting a party' do
    it 'Should show title linking to movie show page, date/time, who is hosting, list of friends my name bold' do
      VCR.use_cassette('my_viewing_party') do
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
        find(:xpath, "//input[@name=#{@friend3.id}]").set(true)
        click_button('Create Party')

        within('.parties') do
          expect(page).to have_content('The Lord of the Rings')
          expect(page).to have_content('April 20, 2021')
          expect(page).to have_content('4:30 PM')
          expect(page).to have_content("Hosting: #{@user.email}")
          expect(page).to have_content("#{@friend1.email}")
          expect(page).to have_content("#{@friend2.email}")
          expect(page).to have_content("#{@friend3.email}")
        end
        
        click_link "Log Out"
        click_link "I already have an account"
        fill_in :email, with: @friend2.email
        fill_in :password, with: "4321"
        click_button "Log In"
        visit dashboard_path
        save_and_open_page
        
        within('.parties') do
          expect(page).to have_content("#{@friend1.email}")
          expect(page).to have_content("#{@friend2.email}")
          expect(page).to have_content("#{@friend3.email}")
          expect(page).to have_content("#{@user.email}")
        end
      end
    end
  end
end
