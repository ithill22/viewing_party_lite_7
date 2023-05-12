require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should validate_presence_of :duration_minutes }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :date }
    it { should validate_presence_of :host_id }
  end

  describe 'relationships' do
    it { should have_many :party_users }
    it { should have_many(:users).through(:party_users) }
  end

  describe 'instance methods', :vcr do
    describe '#movie' do
      it 'returns a movie object' do
        party = Party.create!(duration_minutes: 120, start_time: '01:00:00', date: '2023-08-01', host_id: 1, movie_id: 550)
        expect(party.movie).to be_a(Movie)
        expect(party.movie.title).to eq('Fight Club')
      end
    end
  end
end