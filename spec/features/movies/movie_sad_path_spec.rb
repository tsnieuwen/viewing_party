require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
    @user = User.create(
      email: 'user@example.com',
      password: 'password'
    )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'When the API call to moviedb fails' do
    it 'It redirects me to a discover page with error message' do
      VCR.use_cassette('movie_sad_path') do
      allow(MovieFacade).to receive(:top_rated_movies).and_return(nil)
      visit dashboard_path

      click_button 'Discover Movies'
      click_button 'Find Top Rated Movies'

      expect(current_path).to eq(discover_index_path)
      expect(page).not_to have_content('Vote Average:', count: 40)
      expect(page).to have_content("An error occured, please try again")
      end
    end
    it 'It redirects me to a discover page with error message for show page error' do
      VCR.use_cassette('movie_sad_path2') do
      allow(MovieFacade).to receive(:show_movie).and_return(nil)
      visit movie_path("#{Figaro.env.movie_details}")

      expect(current_path).to eq(discover_index_path)
      expect(page).to have_content("An error occured, please try again")
      end
    end
  end
end