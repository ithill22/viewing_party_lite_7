require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  describe 'relationships' do
    it { should have_many :party_users }
    it { should have_many(:parties).through(:party_users) }
  end

  describe 'instance methods' do
    describe '#name_and_email' do
      it 'returns a string with the user name and email' do
        user = User.create!(name: 'Billy Bob Thornton', email: 'billybob@turing.edu')
        expect(user.name_and_email).to eq('Billy Bob Thornton (billybob@turing.edu)')
      end
    end
  end
end