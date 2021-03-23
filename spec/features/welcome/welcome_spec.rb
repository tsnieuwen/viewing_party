require "rails_helper"

RSpec.describe "When a user visits the home page" do
  scenario "I see a welcome message & brief description" do
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome to Viewing Party")
    within(".description") do
      expect(page).to have_content("Invite your friends to a viewing party!")
    end
  end
end
