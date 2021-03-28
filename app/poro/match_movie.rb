class MatchMovie
	attr_reader :api_id,
							:title,
							:rating

	def initialize(data)
		@api_id = data[:id]
    @title = data[:title]
    @rating = data[:vote_average]
	end

  def self.all_movies(input)
    input.map do |movie|
      MatchMovie.new(movie)
    end
  end
end
