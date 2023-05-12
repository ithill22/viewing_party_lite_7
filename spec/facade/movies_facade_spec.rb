require 'rails_helper'

describe MoviesFacade, :vcr do
  describe 'class methods' do
    it 'top_rated_movies' do
      facade = MoviesFacade.new.top_rated_movies

      expect(facade).to be_an(Array)
      movie_data = facade.first

      expect(movie_data.title).to be_a(String)
      expect(movie_data.title).to eq("The Godfather")
    end

    it 'search_movies' do
      facade = MoviesFacade.new.search_movies("god")
     
      expect(facade).to be_an(Array)
      movie_data = facade.first

      expect(movie_data.title).to be_a(String)
      expect(movie_data.title).to eq("Shazam! Fury of the Gods")
    end

    it 'movie_details' do
      facade = MoviesFacade.new.movie_details(550)

      movie_data = facade
      
      expect(movie_data.title).to be_a(String)
      expect(movie_data.title).to eq("Fight Club")
    end
  end
end