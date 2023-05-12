class MoviesFacade
  def top_rated_movies
    service = MoviesService.new

    json = service.top_rated_movies

    @movies = json[:results][0..19].map do |movie_data|
      Movies.new(movie_data)
    end
  end

  def search_movies(query)
    service = MoviesService.new

    json = service.search_movies(query)

    @movies = json[:results][0..19].map do |movie_data|
      Movies.new(movie_data)
    end
  end

  def movie_details(id)
    service = MoviesService.new

    movie_data = service.movie_details(id)

    @movie = Movies.new(movie_data)
  end
end