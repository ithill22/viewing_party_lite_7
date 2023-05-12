require 'rails_helper'

RSpec.describe "Discover Index Page" do
  before :each do
    @user_1 = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu')
    visit user_discover_index_path(@user_1)
  end

  describe 'as a registered user, when I visit the discover index page' do
    it 'I see a button to find top rated movies' do
      expect(page).to have_button('Find Top Rated Movies')
      click_button 'Find Top Rated Movies'
      expect(current_path).to eq(user_movies_path(@user_1))
    end

    it 'I see a search field to search for movies' do
      expect(page).to have_field(:query)
      expect(page).to have_button('Find Movies')
      click_button 'Find Movies'
      expect(current_path).to eq(user_movies_path(@user_1))
    end
  end
end