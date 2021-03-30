require 'rails_helper'

RSpec.describe TopMovie do
  it "Should build new PORO based on input" do
    input = {
      id: "111",
      title: "Great Movie",
      vote_average: 8.9,
    }
    movie = TopMovie.new(input)

    expect(movie).to be_an_instance_of(TopMovie)
    expect(movie.api_id).to eq("111")
    expect(movie.title).to eq("Great Movie")
    expect(movie.rating).to eq(8.9)
  end
  it "#all_movies" do
    input = [{
      id: "111",
      title: "Great Movie",
      vote_average: 8.9
    },{
      id: "114",
      title: "Greater Movie",
      vote_average: 8.9
    }]
    expected = TopMovie.all_movies(input)

    expect(expected.length).to eq 2
    expect(expected.first).to be_an_instance_of TopMovie
  end
end