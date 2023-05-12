require 'faraday'

class MovieService
  def top_rated_movies
    get_url_results('movie/top_rated')
  end

  def search_movies(query)
    get_url_results('search/movie', { query: query })
  end

  def movie_details(id)
    get_url("movie/#{id}")
  end

  def movie_cast(id)
    get_url_cast("movie/#{id}/credits")
  end

  def movie_reviews(id)
    get_url_results("movie/#{id}/reviews")
  end

  private
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_url_results(url, params={})
    response = conn.get(url, params)
    results = JSON.parse(response.body, symbolize_names: true)[:results]
    results.first(20)
  end

  def get_url_cast(url)
    response = conn.get(url)
    results = JSON.parse(response.body, symbolize_names: true)[:cast]
    results.first(10)
  end

  def conn
    Faraday.new(url: 'https://api.themoviedb.org/3/') do |f|
      f.params['api_key'] = '27497a269af52c0049ba8bfe885390eb'
    end
  end
end


