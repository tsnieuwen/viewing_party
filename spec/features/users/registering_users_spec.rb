require 'rails_helper'

RSpec.describe 'User registration form' do
  scenario 'it creates a new user' do
    visit root_path

    click_link 'Register as a User'

    fill_in 'user[email]', with: 'someone@example.com'
    fill_in 'user[password]', with: 'password1234'

    click_button 'Register User'

    expect(page).to have_content('Welcome someone@example.com!')
  end

  scenario "It keeps a user logged in after registering" do
    visit root_path

    click_on "Register as a User"

    fill_in 'user[email]', with: "funbucket13"
    fill_in 'user[password]', with: "test"

    click_on "Register User"

    visit '/profile'

    expect(page).to have_content("Hello funbucket13!")
  end
end