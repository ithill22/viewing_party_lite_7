require 'rails_helper'

RSpec.describe "Movies Index Page", :vcr do
  before :each do
    @user_1 = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu')
    visit user_discover_index_path(@user_1)
  end
  describe 'as a registered user, when I visit the movies index page' do
    it 'I see a button back to the discover page' do
      click_button 'Find Top Rated Movies'
      expect(current_path).to eq(user_movies_path(@user_1))
      expect(page).to have_button('Discover Page')
      click_button 'Discover Page'
      expect(current_path).to eq(user_discover_index_path(@user_1))
    end

    it 'If I clicked "Find Top Rated Movies" I see a list of the top rated movies' do
      click_button 'Find Top Rated Movies'
      expect(current_path).to eq(user_movies_path(@user_1))
      expect("The Godfather").to appear_before("The Shawshank Redemption")
      expect("The Shawshank Redemption").to appear_before("The Dark Knight")
      expect("The Dark Knight").to_not appear_before("The Godfather")
      expect(page).to have_link("The Godfather")
      click_link "The Godfather"
      expect(current_path).to eq(user_movie_path(@user_1, 238))
    end

    it 'If I clicked "Find Movies" I see a list of movies that match my search' do
      fill_in :query, with: "basketball"
      click_button 'Find Movies'
      expect(current_url).to eq("http://www.example.com/users/#{@user_1.id}/movies?query=basketball&commit=Find+Movies")
      expect(page).to have_link("Kuroko's Basketball the Movie: Last Game")
      expect(page).to have_link("The Basketball Diaries")
      expect(page).to_not have_link("The Godfather")
    end
  end
end