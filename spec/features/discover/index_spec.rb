require 'rails_helper'

RSpec.describe 'users discover index', :vcr do
  describe 'users discover index page' do
    let!(:user_1) { User.create!(name: "Angel Byun", email: "angelbyun@turing.edu") }
    let!(:user_2) { User.create!(name: "Isaac Thill", email: "isaacthill@turing.edu") }
    let!(:user_3) { User.create!(name: "Scott Le", email: "scottle@gmail.com") }
    let!(:user_4) { User.create!(name: "Megan Hinricher", email: "hinmeg@gmail.com") }

    it 'creates a button to the Discover Top Rated Movies' do
      visit "/users/#{user_1.id}/discover"

      click_button("Find Top Rated Movies")

      expect(current_path).to eq("/users/#{user_1.id}/movies")
    end

    it 'creates a text field to search movies by title and a button to search movie by title' do
      visit "/users/#{user_1.id}/discover"

      fill_in(:query, with: "god")
      click_button("Find Movies")

      expect(current_path).to eq("/users/#{user_1.id}/movies")
    end
  end
end