require 'rails_helper'

RSpec.describe ShowMovie do
  it "Should build new PORO based on input" do
    input = {
      id: "111",
      title: "Great Movie",
      overview: "Sweet",
      runtime: 200,
      vote_average: 9.9,
      genres: "Scary",
      poster_path: "amazing/picture.jpeg"
    }
    movie = ShowMovie.new(input)

    expect(movie).to be_an_instance_of(ShowMovie)
    expect(movie.api_id).to eq("111")
    expect(movie.title).to eq("Great Movie")
    expect(movie.summary).to eq("Sweet")
    expect(movie.runtime).to eq(200)
    expect(movie.vote_average).to eq(9.9)
    expect(movie.genres).to eq("Scary")
    expect(movie.poster).to eq("amazing/picture.jpeg")
  end
end