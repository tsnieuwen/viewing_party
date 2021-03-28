require 'rails_helper'
#Kris rocks

RSpec.describe "As an authenticated user" do
  describe "When I visit '/dashboard'" do
    it "I don't see ~Welcome <username> at top of page when not a user" do
      visit root_path

      expect(page).not_to have_link("Dashboard")
    end

    it "Has link at top of the page" do
      user = User.create(
        email: 'user@example.com',
        password: 'test'
      )

      visit root_path

      click_link('I already have an account')
      fill_in :email, with: user.email
      fill_in :password, with: 'test'
      click_button 'Log In'

      expect(page).to have_link('Dashboard')

      click_link 'Dashboard'

      expect(current_path).to eq(dashboard_path)
    end

    it "Has button to discover movies, section for friends and parties" do
      user = User.create(
        email: 'user@example.com',
        password: 'test'
      )

      visit root_path

      click_link('I already have an account')
      fill_in :email, with: user.email
      fill_in :password, with: 'test'
      click_button 'Log In'
      click_link 'Dashboard'

      expect(page).to have_content("Welcome #{user.email}!")
      expect(page).to have_button('Discover Movies')

      within('.friends') do
        expect(page).to have_content('Friends')
      end

      within('.parties') do
        expect(page).to have_content('Viewing Parties')
      end
    end
  end
end
