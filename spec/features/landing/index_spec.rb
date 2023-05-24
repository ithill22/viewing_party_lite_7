require 'rails_helper'

RSpec.describe 'landing page index' do
  describe 'landing page index' do
    let!(:user_1) { User.create!(name: "Angel Byun", email: "angelbyun@turing.edu", password: "test", password_confirmation: "test") }
    let!(:user_2) { User.create!(name: "Isaac Thill", email: "isaacthill@turing.edu", password: "test", password_confirmation: "test") }
    let!(:user_3) { User.create!(name: "Scott Le", email: "scottle@gmail.com", password: "test", password_confirmation: "test") }
    let!(:user_4) { User.create!(name: "Megan Hinricher", email: "hinmeg@gmail.com", password: "test", password_confirmation: "test") }

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
      visit login_path

      fill_in :email, with: user_1.email
      fill_in :password, with: user_1.password

      click_on "Log In"

      visit root_path

      expect(page).to have_content(user_1.name)
      click_link("#{user_1.name}")

      expect(current_path).to eq("/dashboard/#{user_1.id}")

      visit login_path

      fill_in :email, with: user_2.email
      fill_in :password, with: user_2.password

      click_on "Log In"

      visit root_path

      expect(page).to have_content(user_2.name)
      click_link("#{user_2.name}")
      
      expect(current_path).to eq("/dashboard/#{user_2.id}")

      visit login_path

      fill_in :email, with: user_3.email
      fill_in :password, with: user_3.password

      click_on "Log In"

      visit root_path

      expect(page).to have_content(user_3.name)
      click_link("#{user_3.name}")
  
      expect(current_path).to eq("/dashboard/#{user_3.id}")

      visit login_path

      fill_in :email, with: user_4.email
      fill_in :password, with: user_4.password

      click_on "Log In"

      visit root_path
      
      expect(page).to have_content(user_4.name)
      click_link("#{user_4.name}")

      expect(current_path).to eq("/dashboard/#{user_4.id}")
    end

    it 'creates a link to go back to the landing page' do
      visit root_path

      expect(page).to have_link("Home")

      click_link("Home")

      expect(current_path).to eq(root_path)
    end
  end

  it "has a login button" do
    visit root_path
    
    expect(page).to have_button("Log In")

    click_button "Log In"

    expect(current_path).to eq(login_path)
  end

  it 'visitor does not see existing users' do
    user_2 = User.create!(name: "Christopher Byun", email: "chrisb@yahoo.com", password: "test", password_confirmation: "test")
    user_3 = User.create!(name: "Scott Le", email: "scottle123@gmail.com", password: "test", password_confirmation: "test")
    
    visit root_path

    expect(page).to_not have_content("Existing Users")
    expect(page).to_not have_content(user_2.name)
    expect(page).to_not have_content(user_3.name)
  end

  it "registered user can see existing users" do
    user = User.create!(name: "Angel Byun", email: "angelbyun@turing.edu", password: "test", password_confirmation: "test")
    user_2 = User.create!(name: "Christopher Byun", email: "chrisb@yahoo.com", password: "test", password_confirmation: "test")
    user_3 = User.create!(name: "Scott Le", email: "scottle123@gmail.com", password: "test", password_confirmation: "test")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    visit root_path
    
    expect(page).to have_content("Existing Users")
    expect(page).to have_content(user_2.name)
    expect(page).to have_content(user_3.name)
  end
end