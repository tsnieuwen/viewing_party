require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "relationships" do
    it { should have_many :parties }
  end

  describe "validations" do
    it {should validate_presence_of :api_id}
  end

  describe "instance methods" do
    it "#get_details" do
      VCR.use_cassette('movie_model_test1') do
        movie = Movie.create(
          api_id: Figaro.env.movie_details
        )
        expect(movie.get_details.title).to eq("The Lord of the Rings")
        expect(movie.get_details.hours).to eq(2)
        expect(movie.get_details.minutes).to eq(12)
        expect(movie.get_details.runtime).to eq(132)
      end
    end
  end
end
