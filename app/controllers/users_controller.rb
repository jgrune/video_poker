class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.dollars = 100
    @user.save!
    session[:user_id] = @user.id
    flash[:notice] = "Account Successfuly Created!"
    redirect_to hands_path
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path(@user)
  end


private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
