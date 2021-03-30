class MovieFacade
  def self.top_rated_movies
    MovieService.top_rated_movies
  end

  def self.search(term)
    MovieService.forty_match_movies(term)
  end
end