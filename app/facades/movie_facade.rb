class MovieFacade
  def self.top_rated_movies
    MovieService.top_rated_movies
  end

  def self.search(term)
    MovieService.matched_movies(term)
  end

  def self.show_movie(api_id)
    MovieService.show_movie(api_id)
  end

  def self.movie_details(api_id)
    MovieService.reviews(api_id)
  end
end
