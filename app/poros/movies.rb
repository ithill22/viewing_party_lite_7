class Movies
  attr_reader :title,
              :id,
              :description,
              :vote_average,
              :genres,
              :vote_count,
              :image

  def initialize(movie_data)
    @title = movie_data[:title]
    @id = movie_data[:id]
    @description = movie_data[:overview]
    @vote_average = movie_data[:vote_average]
    @genres = movie_data[:genres]
    @vote_count = movie_data[:vote_count]
    @image = movie_data[:poster_path]
  end
end