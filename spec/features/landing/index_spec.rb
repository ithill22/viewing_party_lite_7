require 'rails_helper'

RSpec.describe 'landing page index' do
  describe 'landing page index' do
    let!(:user_1) { User.create!(name: "Angel Byun", email: "angelbyun@turing.edu") }
    let!(:user_2) { User.create!(name: "Isaac Thill", email: "isaacthill@turing.edu") }
    let!(:user_3) { User.create!(name: "Scott Le", email: "scottle@gmail.com") }
    let!(:user_4) { User.create!(name: "Megan Hinricher", email: "hinmeg@gmail.com") }

    it 'has a landing page header' do
      visit root_path

      expect(page).to have_content("Landing Page")
    end

    it 'creates a button to create a new user' do
      visit root_path

      click_button("New User")

      expect(current_path).to eq("/register")
    end

    it 'displays a list of existing users which links to users dashboard' do
      visit root_path

      within "#user-#{user_1.id}" do
        expect(page).to have_content(user_1.name)
        click_link("#{user_1.name}")
      end

      expect(current_path).to eq("/dashboard/#{user_1.id}")
      visit root_path

      within "#user-#{user_2.id}" do
        expect(page).to have_content(user_2.name)
        click_link("#{user_2.name}")
      end
      
      expect(current_path).to eq("/dashboard/#{user_2.id}")
      visit root_path

      within "#user-#{user_3.id}" do
        expect(page).to have_content(user_3.name)
        click_link("#{user_3.name}")
      end

      expect(current_path).to eq("/dashboard/#{user_3.id}")
      visit root_path
      
      within "#user-#{user_4.id}" do
        expect(page).to have_content(user_4.name)
        click_link("#{user_4.name}")
      end

      expect(current_path).to eq("/dashboard/#{user_4.id}")
    end

    it 'creates a link to go back to the landing page' do
      visit root_path

      expect(page).to have_link("Home")

      click_link("Home")

      expect(current_path).to eq(root_path)
    end
  end
end