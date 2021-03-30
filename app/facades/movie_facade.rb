class MovieFacade
  def self.top_rated_movies
    MovieService.top_rated_movies
  end

  def self.search(term)
    MovieService.matched_movies(term)
    # movies[0..39]
  end

  def self.show_movie(api_id)
    MovieService.show_movie(api_id)
  end

  def self.get_details(api_id)
    MovieService.reviews(api_id)
  end
end