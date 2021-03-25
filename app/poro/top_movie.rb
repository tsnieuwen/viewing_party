class TopMovie
	attr_reader :api_id,
							:title,
							:rating

	def initialize(data)
		@api_id = data[:id]
    @title = data[:title]
    @rating = data[:vote_average]
	end

end
