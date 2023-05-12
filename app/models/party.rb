class Party < ApplicationRecord
  validates_presence_of :duration_minutes,
                        :start_time,
                        :date,
                        :host_id,
                        :movie_id
                        
  has_many :party_users
  has_many :users, through: :party_users

  def movie
    MovieFacade.new.movie_details(movie_id)
  end
end