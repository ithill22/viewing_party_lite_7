class PartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @users = User.all
    @party = Party.new
    @movie = MovieFacade.new.movie_details(params[:movie_id])
  end

  def create
    @party = Party.new(party_params)
    # require 'pry'; binding.pry
    if @party.save
      create_party_users(params[:users], party.id, params[:user_id])
      redirect_to dashboard_path(params[:user_id]), notice: "Party successfully created!"
    else
      redirect_to new_user_movie_party_path(params[:user_id], params[:movie_id]), notice: "Please fill in all fields"
    end
  end

  private
  def party_params
    params.require(:party).permit(:duration_minutes, :start_time, :date, :movie_id, :host_id, users: [])
  end

  def create_party_users(users, party_id, host_id)
    PartyUser.create!(user_id: host_id, party_id: party_id)
    users.reject { |user, checkbox| checkbox == "0" }.each do |user_id, checkbox|
      PartyUser.create!(user_id: user[0].to_i, party_id: party_id)
    end
  end
end