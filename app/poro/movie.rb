class Movie
	attr_reader :api_id,

	def initialize(data)
		@api_id = data[:id]
	end

end
