class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @parties = @user.parties
  end

  def new
  end

  def create
    @user = User.new(user_params)
    # require 'pry'; binding.pry
    if @user.password != @user.password_confirmation
      flash[:alert] = "Passwords do not match!"
      render :new
    elsif @user.save
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to dashboard_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :new
    end
    #   session[:user_id] = @user.id
    #   redirect_to dashboard_path(@user), notice: "Welcome to Viewing Party!"
    # else
    #   redirect_to register_path, notice: "Email already exists"
    # end
    # user = User.create(user_params)
    # redirect_to dashboard_path(user)
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path(user), notice: "Welcome back, #{user.name}!"
    else
      flash[:alert] = "Invalid Credentials"
      render login_form
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end