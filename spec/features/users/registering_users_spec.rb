require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit root_path 

    click_on "Register as a User"

    expect(current_path).to eq("/users/new")

    email = "funbucket13"
    password = "test"

    fill_in :email, with: email
    fill_in :password, with: password

    click_on "Register User"

    expect(page).to have_content("Welcome, #{email}!")
  end
end