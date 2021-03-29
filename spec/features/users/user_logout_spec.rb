require 'rails_helper'

RSpec.describe 'User can log out' do
  scenario 'Can log out after being logged in' do
    user = User.create(email: 'great@example.com', password: '1234')

    visit root_path

    click_link 'I already have an account'

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: '1234'

    click_button 'Log In'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome #{user.email}!")

    click_link('Log Out')

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have been logged out")
  end
end