class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    # $$$$ validate username does not already exist!! $$$$

    # if params[:username] > @current_user.dollars
    #   flash[:alert] = "You don't have enough money to bet that amount!"
    #   redirect_to new_hand_path
    # elsif params[:bet].to_i < 0
    #   flash[:alert] = "You must enter a bet greater than zero"
    #   redirect_to new_hand_path
    # else

    @user = User.create(user_params)
    @user.dollars = 100
    @user.save!
    session[:user_id] = @user.id
    flash[:notice] = "Account Successfuly Created!"
    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @current_user.reload_balance
    redirect_to @current_user
  end

private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
