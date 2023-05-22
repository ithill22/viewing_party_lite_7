require 'rails_helper'

RSpec.describe 'User Registration Page' do
  before :each do
    visit register_path
  end

  describe 'as a new user, when I visit the user registration page' do
    it 'I see a form to register as a new user' do
      expect(page).to have_field('Name:')
      expect(page).to have_field('Email:')
      expect(page).to have_field('Password:')
      expect(page).to have_field('Confirm Password:')      
      expect(page).to have_button('Create New User')
    end

    it 'I can fill out the form and submit to create a new user' do
      fill_in 'Name:', with: 'Test User'
      fill_in 'Email:', with: 'test_email@turing.edu'
      fill_in 'Password:', with: 'test_password'
      fill_in 'Confirm Password:', with: 'test_password'
      click_button 'Create New User'

      expect(current_path).to eq(dashboard_path(User.last))
      expect(page).to have_content('Welcome to Viewing Party!')
    end

    it 'I cannot create a new user without a unique email address' do
      User.create!(name: 'Test User', email: 'test_email@turing.edu', password: 'test_password', password_confirmation: 'test_password')
      fill_in 'Name:', with: 'Test User'
      fill_in 'Email:', with: 'test_email@turing.edu'
      fill_in 'Password:', with: 'test_password'
      fill_in 'Confirm Password:', with: 'test_password'
      click_button 'Create New User'

      expect(current_path).to_not eq(dashboard_path(User.last))
      expect(current_path).to eq(register_path)
    end

    it 'I cannot create a new user without a matching password and password confirmation' do
      fill_in 'Name:', with: 'Test User'
      fill_in 'Email:', with: 'test@turing.edu'
      fill_in 'Password:', with: 'test_password'
      fill_in 'Confirm Password:', with: 'test_password_2'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Passwords do not match.')
    end
  end
end