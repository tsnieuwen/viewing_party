require 'rails_helper'

RSpec.describe MovieFacade do
  describe "Methods" do
    it "#top_rated_movies" do
      VCR.use_cassette('movie_facade_test1') do
        movies = MovieFacade.top_rated_movies

        expect(movies).to be_an(Array)
        expect(movies.length).to eq 40
      end
    end
    it "#search" do
      VCR.use_cassette('movie_facade_test2') do
        input = "Lord of the Rings"
        movies = MovieFacade.search(input)
      
        expect(movies).to be_an(Array)
        expect(movies.first).to be_an_instance_of MatchMovie
      end
    end
    it "#show_movie" do
      VCR.use_cassette('movie_facade_test3') do
        input = "123"
        movie = MovieFacade.show_movie(input)

        expect(movie).to be_an_instance_of ShowMovie
        expect(movie.title).to eq("The Lord of the Rings")
      end
    end
    it "#get_details" do
      VCR.use_cassette('movie_facade_test4') do
        input = "100"
        details = MovieFacade.get_details(input)

        expect(details).to be_a(Hash)
        expect(details[:all_reviews].length).to eq 3
        expect(details[:all_cast].length).to eq 30
      end
    end
  end
end