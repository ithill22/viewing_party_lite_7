require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password}
    it { should have_secure_password }
  end

  describe 'relationships' do
    it { should have_many :party_users }
    it { should have_many(:parties).through(:party_users) }
  end

  describe 'instance methods' do
    describe '#name_and_email' do
      it 'returns a string with the user name and email' do
        user = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu', password: 'password123', password_confirmation: 'password123')
        expect(user.name_and_email).to eq('Billy Bob Thornton (billybob@turing.edu)')
      end
    end
  end

  it 'can create a new user' do
    user = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu', password: 'password123', password_confirmation: 'password123')

    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq('password123')
  end
end