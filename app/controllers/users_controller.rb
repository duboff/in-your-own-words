class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find params[:id]
    @user.update! params[:user].permit(:name, :cv)
    redirect_to user_path(@user)
  end
end
