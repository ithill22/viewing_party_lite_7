class MovieFacade
  def top_rated_movies
    service.top_rated_movies.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def search_movies(query)
    service.search_movies(query).map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def movie_details(id)
    movie_data = service.movie_details(id)
    Movie.new(movie_data)
  end

  def movie_cast(id)
    service.movie_cast(id).map do |actor_data|
      Actor.new(actor_data)
    end
  end

  def movie_reviews(id)
    service.movie_reviews(id).map do |review_data|
      Review.new(review_data)
    end
  end

  private
  def service
    _service ||= MovieService.new
  end
end