require 'faraday'

class MoviesService
  def top_rated_movies
    get_url('movie/top_rated')
  end

  def search_movies(query)
    get_url("search/movie?query=#{query}")
  end

  def movie_details(id)
    get_url("movie/#{id}")
  end
  
  private
  def get_url(url, params = {})
    response = conn.get(url, params = {})
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.themoviedb.org/3/') do |faraday|
      faraday.params['api_key'] = '36acc11d0b7885d17ebfda349d918f87'
    end
  end
end