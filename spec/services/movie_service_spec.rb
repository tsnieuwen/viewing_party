require 'rails_helper'

RSpec.describe MovieService do
  describe "Methods" do
    it "top_rated_movies" do
      VCR.use_cassette('movie_service_test1') do
        movies = MovieService.top_rated_movies
  
        expect(movies).to be_an(Array)
        expect(movies.length).to eq 40
      end
    end
    it "search" do
      VCR.use_cassette('movie_service_test2') do
        input = "Lord of the Rings"
        movies = MovieService.matched_movies(input)
        
        expect(movies).to be_an(Array)
        expect(movies.first).to be_an_instance_of MatchMovie
        expect(movies.length).not_to eq 40
      end
    end
    it "reviews" do
      VCR.use_cassette('movie_service_test30') do
        input = "100"
        details = MovieService.reviews(input)

        expect(details).to be_a(Hash)
        expect(details[:all_reviews].length).to eq 3
        expect(details[:all_cast].length).to eq 10
      end
    end
  end
end