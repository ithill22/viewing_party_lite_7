require 'rails_helper'

describe MoviesService, :vcr do
  describe 'class methods' do
    it 'top_rated_movies' do
      service = MoviesService.new.top_rated_movies

      expect(service[:results]).to be_an(Array)
      movie_data = service[:results].first

      expect(movie_data).to have_key(:title)
      expect(movie_data[:title]).to be_a(String)
      expect(movie_data[:title]).to eq("The Godfather")
    end

    it 'search_movies' do
      service = MoviesService.new.search_movies("god")
     
      expect(service[:results]).to be_an(Array)
      movie_data = service[:results].first

      expect(movie_data).to have_key(:title)
      expect(movie_data[:title]).to be_a(String)
      expect(movie_data[:title]).to eq("Shazam! Fury of the Gods")
    end

    it 'movie_details' do
      service = MoviesService.new.movie_details(550)

      expect(service).to be_a(Hash)
      movie_data = service
      
      expect(movie_data).to have_key(:title)
      expect(movie_data[:title]).to be_a(String)
      expect(movie_data[:title]).to eq("Fight Club")
    end
  end
end