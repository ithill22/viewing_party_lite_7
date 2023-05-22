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
  
    if @user.password != @user.password_confirmation
      flash.now[:alert] = "Passwords do not match."
      render :new
    elsif @user.save
      redirect_to dashboard_path(@user), notice: "Welcome to Viewing Party!"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path(user), notice: "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "Invalid credentials."
      render :login_form
    end
  end
  

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end