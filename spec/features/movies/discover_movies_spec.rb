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

      expect(page).to have_content('Vote Average:', count: 40)
      end
    end

    it 'Has search text field for movie' do
      visit discover_index_path

      expect(page).to have_field('search')
      expect(page).to have_xpath("//input[@value='Search by movie title']")
      expect(page).to have_button('Find Movies')
    end

    it 'Search brings me to movies page' do
      VCR.use_cassette('Find Movies 1') do
        visit discover_index_path

        fill_in :search, with: 'GoodFellas'
        click_button 'Find Movies'
        expect(page).to have_link('GoodFellas')
        expect(page).to have_content('Vote Average:')
      end
    end

    it 'Search only returns 40 results' do
      VCR.use_cassette('Find Movies 3') do
        visit discover_index_path

        fill_in :search, with: 'The'
        click_button 'Find Movies'
        expect(page).to have_content('Vote Average:', count: 40)
      end
    end
  end
end
