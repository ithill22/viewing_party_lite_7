class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @parties = @user.parties
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path(@user), notice: "Welcome to Viewing Party!"
    else
      redirect_to register_path, notice: "Email already exists"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end