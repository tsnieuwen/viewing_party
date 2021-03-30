require 'rails_helper'

RSpec.describe MovieFacade do
  describe "Methods" do
    it "#top_rated_movies" do
      VCR.use_cassette('movie_facade_test1') do
      @movies = MovieFacade.top_rated_movies

      expect(@movies).to be_an(Array)
      expect(@movies.length).to eq 40
      end
    end
    it "#search" do
      VCR.use_cassette('movie_facade_test2') do
      term = "The Lord of the Rings"
      @movies = MovieFacade.search(term)

      expect(@movies).to be_an(Array)
      expect(@movies.length).not_to eq 40
      end
    end
  end
end