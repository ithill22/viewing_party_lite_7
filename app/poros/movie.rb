class Movie
  attr_reader :title,
              :id,
              :summary,
              :vote_average,
              :runtime,
              :genre_ids,
              :genres,
              :vote_count,
              :image,
              :tagline

  def initialize(movie_data)
    @title = movie_data[:title]
    @id = movie_data[:id]
    @summary = movie_data[:overview]
    @vote_average = movie_data[:vote_average]
    @runtime = movie_data[:runtime]
    @genre_ids = movie_data[:genre_ids]
    @genres = movie_data[:genres]
    @vote_count = movie_data[:vote_count]
    @image = movie_data[:poster_path]
    @tagline = movie_data[:tagline]
  end
end