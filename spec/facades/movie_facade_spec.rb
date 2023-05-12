require 'rails_helper'

RSpec.describe MovieFacade, :vcr do
  describe 'instance methods' do
    describe '#top_rated_movies' do
      it 'returns an array of top rated movies' do
        top_rated = MovieFacade.new.top_rated_movies
        expect(top_rated).to be_an(Array)
        movie_data = top_rated.first
        expect(movie_data).to be_a(Movie)
        expect(movie_data.title).to be_a(String)  
        expect(movie_data.title).to eq("The Godfather")
      end
    end

    describe '#search_movies' do
      it 'returns an array of movies that match the search query' do
        results = MovieFacade.new.search_movies('basketball')
        expect(results).to be_an(Array)
        movie_data = results.first
        expect(movie_data).to be_a(Movie)
        expect(movie_data.title).to be_a(String)
        expect(movie_data.title).to eq("Kuroko's Basketball the Movie: Last Game")
      end
    end

    describe '#movie_details' do
      it 'returns a movie object with details' do
        movie = MovieFacade.new.movie_details(278)
        expect(movie).to be_a(Movie)
        expect(movie.title).to be_a(String)
        expect(movie.title).to eq("The Shawshank Redemption")
      end
    end

    describe '#movie_cast' do
      it 'returns an array of actors' do
        movie = MovieFacade.new.movie_cast(278)
        expect(movie).to be_an(Array)
        expect(movie.first).to be_a(Actor)
        expect(movie.first.name).to be_a(String)
        expect(movie.first.name).to eq("Tim Robbins")
      end
    end

    describe '#movie_reviews' do
      it 'returns an array of reviews' do
        movie = MovieFacade.new.movie_reviews(278)
        expect(movie).to be_an(Array)
        expect(movie.first).to be_a(Review)
        expect(movie.first.author).to be_a(String)
        expect(movie.first.author).to eq("elshaarawy")
      end
    end
  end
end