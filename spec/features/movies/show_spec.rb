require 'rails_helper'

RSpec.describe 'Movie Show Page', :vcr do
  before :each do
    @user_1 = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu')
    visit user_movie_path(@user_1, 278)
  end
  describe 'as a visitor, when I visit the movie show page' do
    it 'I see the movie title, vote average, runtime, and genre(s)' do
      expect(page).to have_content('The Shawshank Redemption')
      expect(page).to have_content('Vote: 8.7')
      expect(page).to have_content('Runtime: 142 minutes')
      expect(page).to have_content('Genre(s): Drama, Crime')
      expect(page).to have_content('Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.')
    end

    it 'I see a button back to the discover page' do
      expect(page).to have_button('Discover Page')
      click_button 'Discover Page'
      expect(current_path).to eq(user_discover_index_path(@user_1))
    end

    it 'I see a button to Create Viewing Party' do
      expect(page).to have_button("Create Viewing Party for The Shawshank Redemption")
      click_button 'Create Viewing Party for The Shawshank Redemption'
      expect(current_path).to eq(new_user_movie_party_path(@user_1, 278))
    end
  end
end