class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if User.find_by(username: params[:user][:username])
      flash[:alert] = "Username is already taken!"
      redirect_to new_user_path
    else
      @user = User.create(user_params)
      @user.dollars = 100
      @user.save!
      session[:user_id] = @user.id
      flash[:notice] = "Account Successfuly Created!"
      redirect_to @user
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @current_user.reload_balance
    redirect_to @current_user
  end

  def statistics
    @hand_ranks = ["Royal Flush", "Straight Flush", "Four of a Kind", "Full House", "Flush", "Straight", "Three of a Kind", "Two Pair", "Pair", "High Card"]
  end

private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
