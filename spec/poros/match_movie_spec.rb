require 'rails_helper'

RSpec.describe MatchMovie do
  it "Should build new PORO based on input" do
    input = {
      id: "111",
      title: "Great Movie",
      vote_average: 9.9
    }
    movie = MatchMovie.new(input)

    expect(movie).to be_an_instance_of(MatchMovie)
    expect(movie.api_id).to eq("111")
    expect(movie.title).to eq("Great Movie")
    expect(movie.rating).to eq 9.9
  end
end