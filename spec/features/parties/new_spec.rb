require 'rails_helper'

RSpec.describe 'New Party Page', :vcr do
  before :each do
    @user_1 = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu')
    @user_2 = User.create!(name: 'Sandra Bullock', email: 'sandy@turing.edu')
    @user_3 = User.create!(name: 'Tom Hanks', email: 'tom@turing.edu')
    @user_4 = User.create!(name: 'Will Smith', email: 'will@turing.edu')
    @movie = MovieFacade.new.movie_details(278)
    visit new_user_movie_party_path(@user_1, @movie.id)
  end
  describe 'as a registered user, when I visit the new party page' do
    it 'I see a button back to the discover page' do
      expect(page).to have_button('Discover Page')
      click_button 'Discover Page'
      expect(current_path).to eq(user_discover_index_path(@user_1))
    end

    it 'I see a form to create a new party' do
      expect(page).to have_content('Create a Movie Party for The Shawshank Redemption')
      expect(page).to have_field(:party_duration_minutes)
      expect(page).to have_field(:party_date)
      expect(page).to have_field(:party_start_time)
      expect(page).to have_button('Create Party')
      expect(page).to have_content('Invite Other Users')
    end

    it 'I can fill out the form and submit to create a new party' do
      fill_in :party_duration_minutes, with: 120
      fill_in :party_date, with: '2023-08-01'
      fill_in :party_start_time, with: '12:00 PM'
      check @user_2.name
      check @user_3.name
      click_button 'Create Party'

      expect(current_path).to eq(dashboard_path(@user_1))
      within '#viewing-party-list' do
        expect(page).to have_content(@movie.title)
      end
    end
  end
end