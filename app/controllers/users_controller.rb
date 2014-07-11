class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  # respond_to :json, :html

  def index
    @users = User.all.reverse[0..10]
  end

  def search
    skill_results = Skill.search(params[:query]).map(&:users).flatten.uniq
    user_results = User.search(params[:query]).to_a
    @users = (skill_results + user_results).uniq
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

  def find_users_with_skill(skill)

  end

end
