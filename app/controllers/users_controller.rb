class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @users = User.all
  end

  def search
    @users = User.search(params[:query])
    render action: "index"
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

  # def upload
  #   # puts params.inspect
  #   @user = current_user
  #   @user.audio = params['audio']
  #   @user.save!
  #   respond_to do |format|
  #     if @user.save
  #       format.json { head :ok }
  #     else
  #       format.json { render :json => @user.errors, :status => :unprocessable_entity }
  #     end
  #   end
  #   # redirect_to user_path(@user)
  # end

end
