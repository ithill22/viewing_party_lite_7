require 'rails_helper'

RSpec.describe 'User login page' do
  before :each do
    @user_1 = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu', password: 'password123', password_confirmation: 'password123')
    visit login_path
  end

  describe 'as a registered user, when I visit the login page' do
    it 'I see a form to login' do
      expect(page).to have_field('Email:')
      expect(page).to have_field('Password:')
      expect(page).to have_button('Log In')
    end

    it 'I can fill out the form and submit to login' do
      fill_in 'Email:', with: 'billybob@turing.edu'
      fill_in 'Password:', with: 'password123'
      click_button 'Log In'

      expect(current_path).to eq(dashboard_path(@user_1))
    end

    it 'I cannot login with invalid credentials' do
      fill_in 'Email:', with: 'billybob@turing.edu'
      fill_in 'Password:', with: 'password1234'
      click_button 'Log In'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Invalid credentials.')
    end
  end
end