require 'rails_helper'

RSpec.describe 'User can log in' do
  scenario 'With valid credentials' do
    user = User.create(email: 'great@example.com', password: '1234')

    visit root_path

    click_link 'I already have an account'

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: '1234'

    click_button 'Log In'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome #{user.email}!")
  end
  
  # scenario 'With invalid credentials' do
  #   user = User.create(email: 'great@example.com', password: '1234')

  #   visit root_path

  #   click_link 'I already have an account'

  #   expect(current_path).to eq(login_path)

  #   fill_in :email, with: user.email
  #   fill_in :password, with: '11'

  #   click_button 'Log In'

  #   expect(page).to have_content("User does not exist")
  #   expect(page).not_to have_link('I already have an account')
  #   expect(page).not_to have_link('Register User')
  # end
end