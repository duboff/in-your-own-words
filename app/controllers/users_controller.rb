class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  # respond_to :json, :html

  def index
    @users = User.all
  end

  def search
    @users = User.search(params[:query])
    render action: "index"
  end

  def show
    @user = User.find params[:id]
    respond_to do |format|
      format.json {render json: @user, :include => {skills: {only: [:id, :name]}}, except: [:created_at, :updated_at, :provider, :uid]}
      format.html
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = current_user
    @user.update! params[:user].permit(:name, :headline, :location) if params
    respond_to do |format|
      if @user.save
        format.json { head :ok }
        format.html {render :show}
      else
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # def

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
