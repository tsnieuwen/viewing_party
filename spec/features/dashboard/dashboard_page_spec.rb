require 'rails_helper'

RSpec.describe "As an authenticated user" do
  describe "When I visit '/dashboard'" do
    before :each do
      @user = User.create(
        email: 'user@example.com',
        password: 'test'
      )
    end
    it "I see ~Welcome <username> at top of page" do
      visit root_path

      click_link 'Dashboard'

      expect(current_path).to eq(dashboard_path)
    end

    it "Has button to discover movies"
    it "Has section for friends"
    it "Has a viewing parties section"
  end
end