class Movie
	attr_reader :api_id,
							:title,
							:description

	def initialize(data)
		@api_id = data[:id]
	end

	def self.all_movies(data)
		total_results.map do |data|
			Movie.new(data)
		end
	end
end
