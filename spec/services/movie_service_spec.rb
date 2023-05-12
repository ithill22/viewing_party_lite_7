require 'rails_helper'

RSpec.describe MovieService, :vcr do
  describe 'class methods' do
    describe '::top_rated_movies' do
      it 'returns an array of top rated movies' do
        top_rated = MovieService.new.top_rated_movies
        expect(top_rated).to be_an(Array)
        expect(top_rated.count).to eq(20)
        movie_data = top_rated.first

        expect(movie_data).to have_key(:title)
        expect(movie_data[:title]).to be_a(String)

        expect(movie_data).to have_key(:vote_average)
        expect(movie_data[:vote_average]).to be_a(Float)

        expect(movie_data).to have_key(:id)
        expect(movie_data[:id]).to be_an(Integer)

        expect(movie_data).to have_key(:overview)
        expect(movie_data[:overview]).to be_a(String)

        expect(movie_data).to have_key(:poster_path)
        expect(movie_data[:poster_path]).to be_a(String)

        expect(movie_data).to have_key(:genre_ids)
        expect(movie_data[:genre_ids]).to be_an(Array)

        expect(movie_data).to have_key(:vote_count)
        expect(movie_data[:vote_count]).to be_an(Integer)
      end
    end

    describe '::search_movies' do
      it 'returns an array of movies that match the search query' do
        search_results = MovieService.new.search_movies('basketball')
        expect(search_results).to be_an(Array)
        expect(search_results.count).to eq(20)
        movie_data = search_results.first

        expect(movie_data).to have_key(:title)
        expect(movie_data[:title]).to be_a(String)

        expect(movie_data).to have_key(:vote_average)
        expect(movie_data[:vote_average]).to be_a(Float)

        expect(movie_data).to have_key(:id)
        expect(movie_data[:id]).to be_an(Integer)

        expect(movie_data).to have_key(:overview)
        expect(movie_data[:overview]).to be_a(String)

        expect(movie_data).to have_key(:poster_path)
        expect(movie_data[:poster_path]).to be_a(String)

        expect(movie_data).to have_key(:genre_ids)
        expect(movie_data[:genre_ids]).to be_an(Array)

        expect(movie_data).to have_key(:vote_count)
        expect(movie_data[:vote_count]).to be_an(Integer)
      end
    end

    describe '::movie_details' do
      it 'returns a movie object with details' do
        movie = MovieService.new.movie_details(278)
        expect(movie).to be_a(Hash)

        expect(movie).to have_key(:title)
        expect(movie[:title]).to be_a(String)

        expect(movie).to have_key(:vote_average)
        expect(movie[:vote_average]).to be_a(Float)

        expect(movie).to have_key(:id)
        expect(movie[:id]).to be_an(Integer)

        expect(movie).to have_key(:overview)
        expect(movie[:overview]).to be_a(String)

        expect(movie).to have_key(:poster_path)
        expect(movie[:poster_path]).to be_a(String)

        expect(movie).to have_key(:genres)
        expect(movie[:genres]).to be_an(Array)

        expect(movie).to have_key(:vote_count)
        expect(movie[:vote_count]).to be_an(Integer)

        expect(movie).to have_key(:runtime)
        expect(movie[:runtime]).to be_an(Integer)

        expect(movie).to have_key(:tagline)
        expect(movie[:tagline]).to be_a(String)
      end
    end

    describe '::movie_cast' do
      it 'returns an array of actors' do
        movie = MovieService.new.movie_cast(278)
        expect(movie).to be_an(Array)

        expect(movie.first).to have_key(:name)
        expect(movie.first[:name]).to be_a(String)

        expect(movie.first).to have_key(:character)
        expect(movie.first[:character]).to be_a(String)
      end
    end

    describe '::movie_reviews' do
      it 'returns an array of reviews' do
        movie = MovieService.new.movie_reviews(278)
        expect(movie).to be_an(Array)

        expect(movie.first).to have_key(:author)
        expect(movie.first[:author]).to be_a(String)

        expect(movie.first).to have_key(:content)
        expect(movie.first[:content]).to be_a(String)
      end
    end
  end
end