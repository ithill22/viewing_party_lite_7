require 'rails_helper'

RSpec.describe Movie, type: :poro do
  before :each do
    @movie = Movie.new({title: "The Godfather", vote_average: 8.7, runtime: 175, genres: [{name: "Drama"}, {name: "Crime"}], overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family in New York City.", id: 238})
  end
  describe 'initialize' do
    it 'exists with attributes' do
      expect(@movie).to be_a(Movie)
      expect(@movie.title).to eq("The Godfather")
      expect(@movie.vote_average).to eq(8.7)
      expect(@movie.runtime).to eq(175)
      expect(@movie.genres).to eq([{name: "Drama"}, {name: "Crime"}])
      expect(@movie.summary).to eq("Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family in New York City.")
      expect(@movie.id).to eq(238)
    end
  end
end