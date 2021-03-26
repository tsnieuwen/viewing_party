require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  describe 'When I visit a movies detail page' do
    it 'Should have a button to create viewing party' do
    
    VCR.use_cassette('single_movie_details') do
    visit movie_path("#{Figaro.env.movie_details}")

    expect(page).to have_button("Create Viewing Party for The Lord of the Rings")
    expect(page).to have_content("The Lord of the Rings")
    expect(page).to have_content("6.5")
    expect(page).to have_content("Adventure")
    expect(page).to have_content("Animation")
    expect(page).to have_content("Fantasy")
    expect(page).to have_content("Summary")
    expect(page).to have_content("Reviews")
    end
    end
  end
end



# As an authenticated user,
# When I visit the movie's detail page,
# I should see

#  Button to create a viewing party
# Details This button should take the 
# authenticated user to the new event page

# And I should see the following 
# information about the movie:

#  Movie Title
#  Vote Average of the movie
#  Runtime in hours & minutes
#  Genere(s) associated to movie
#  Summary description
#  List the first 10 cast members 
# (characters&actress/actors)
#  Count of total reviews
#  Each review's author and information