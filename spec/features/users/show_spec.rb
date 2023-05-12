require 'rails_helper'

RSpec.describe 'User Dashboard Page', :vcr do
  before :each do
    @user_1 = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu')
    @user_2 = User.create!(name: 'Sandra Bullock', email: 'sandy@turing.edu')
    @user_3 = User.create!(name: 'Tom Hanks', email: 'tom@turing.edu')
    @user_4 = User.create!(name: 'Will Smith', email: 'will@turing.edu')

    @party_1 = Party.create!(duration_minutes: 120, start_time: '01:00:00', date: '2023-08-01', host_id: @user_1.id, movie_id: 550)
    @party_2 = Party.create!(duration_minutes: 200, start_time: '02:30:00', date: '2025-10-25', host_id: @user_1.id, movie_id: 378)
    @party_3 = Party.create!(duration_minutes: 90, start_time: '03:00:00', date: '2022-12-31', host_id: @user_2.id, movie_id: 421)
    @party_4 = Party.create!(duration_minutes: 150, start_time: '04:00:00', date: '2024-01-01', host_id: @user_2.id, movie_id: 222)

    @party_user_1 = PartyUser.create!(user_id: @user_1.id, party_id: @party_1.id, host_id: @user_1.id)
    @party_user_2 = PartyUser.create!(user_id: @user_2.id, party_id: @party_1.id, host_id: @user_1.id)
    @party_user_3 = PartyUser.create!(user_id: @user_3.id, party_id: @party_1.id, host_id: @user_1.id)
    @party_user_4 = PartyUser.create!(user_id: @user_4.id, party_id: @party_1.id, host_id: @user_1.id)
    @party_user_5 = PartyUser.create!(user_id: @user_1.id, party_id: @party_2.id, host_id: @user_1.id)
    @party_user_6 = PartyUser.create!(user_id: @user_2.id, party_id: @party_2.id, host_id: @user_1.id)
    @party_user_7 = PartyUser.create!(user_id: @user_3.id, party_id: @party_2.id, host_id: @user_1.id)
    @party_user_8 = PartyUser.create!(user_id: @user_1.id, party_id: @party_3.id, host_id: @user_2.id)
    @party_user_9 = PartyUser.create!(user_id: @user_2.id, party_id: @party_3.id, host_id: @user_2.id)
    @party_user_10 = PartyUser.create!(user_id: @user_3.id, party_id: @party_3.id, host_id: @user_2.id)

    visit dashboard_path(@user_1)
  end

  describe 'as a registered user, when I visit my dashboard' do
    it 'I see users name dashboard' do
      expect(page).to have_content("Billy Bob Thornton's Dashboard")
      expect(page).to_not have_content("Sandra Bullock's Dashboard")
    end

    it 'I see a button to discover movies' do
      expect(page).to have_button('Discover Movies')
      click_button 'Discover Movies'
      expect(current_path).to eq(user_discover_index_path(@user_1))
    end

    it 'I see a list of parties I am hosting or invited to' do
      expect(page).to have_content('Viewing Parties')
      within '#viewing-party-list' do
        expect(page).to have_content(@party_1.movie.title)
        expect(page).to have_content(@party_2.movie.title)
        expect(page).to have_content(@party_3.movie.title)
        expect(page).to_not have_content(@party_4.movie.title)
      end

      within "#party-#{@party_1.id}" do
        expect(page).to have_selector("img[src='https://image.tmdb.org/t/p/w500/#{@party_1.movie.image}']")
        expect(page).to have_content(@party_1.date)
        expect(page).to have_content(@party_1.start_time)
        expect(page).to have_content("Hosting")
        expect(page).to_not have_content("Invited")
      end

      within "#party-#{@party_3.id}" do
        expect(page).to have_content("Invited")
        expect(page).to_not have_content("Hosting")
      end
    end
  end
end