require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  describe 'When I visit a movies detail page' do
    it 'Should have a button to create viewing party' do
      UserParty.destroy_all
      Party.destroy_all
      Movie.destroy_all
      user = User.create(
        email: 'foo@bar.com',
        password: 'test'
      )
      expected = Movie.all
      expect(expected).to be_empty
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette('single_movie_details1010') do
      visit movie_path("#{Figaro.env.movie_details}")
      expected2 = Movie.all
      expect(expected2).not_to be_empty
      expect(page).to have_button("Create Viewing Party for The Lord of the Rings")
      expect(page).to have_content("The Lord of the Rings")
      expect(page).to have_content("6.5")
      expect(page).to have_content("Adventure")
      expect(page).to have_content("Animation")
      expect(page).to have_content("Fantasy")
      expect(page).to have_content("The Fellowship of the Ring embark")
      expect(page).to have_content("Total Reviews: 0")
      expect(page).to have_content("Christopher Guard as Frodo")
      end
    end
  end
end
