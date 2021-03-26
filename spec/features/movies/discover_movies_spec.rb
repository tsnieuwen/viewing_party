require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
    @friend1 = User.create(
      email: 'greatfriend@example.com',
      password: '1223'
    )
    friend2 = User.create(
      email: 'bestestfriend@example.com',
      password: '4321'
    )
    @user = User.create(
      email: 'user@example.com',
      password: 'password'
    )
    visit login_path
    fill_in :email, with: 'user@example.com'
    fill_in :password, with: 'password'
    click_button 'Log In'
  end

  describe 'When I click ~Discover Movies~ button' do
    it 'It redirects me to a discover page' do
      visit dashboard_path

      click_button 'Discover Movies'

      expect(current_path).to eq(discover_index_path)
    end
  end

  describe 'When I visit the discover page' do
    it 'Has a button to discover top 40 movies' do
      visit discover_index_path

      expect(page).to have_button('Find Top Rated Movies')
    end

    it 'Takes me to the movies page' do
      VCR.use_cassette('Top Rated Movies 1') do
      visit discover_index_path

      click_button('Find Top Rated Movies')

      expect(page).to have_content('Vote Average:')
      end
    end
    it 'Has search text field for movie'
    it 'Search brings me to movies page'
  end
end



# As an authenticated user,
# When I visit the '/discover' path
# I should see
#
#  Button to Discover top 40 movies
# Details When the user clicks on the
# top 40 button they should be taken to the movies page.
#
#  A text field to enter keyword(s)
#  to search by movie title
#  A Button to Search by Movie Title
# Details When the user clicks on the
# Search button they should be taken to the movies page
#
# The movies will be retrieved by
# consuming The MovieDB API
