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

  def upload
    uuid = UUID.generate
    puts params.inspect
    # audio_type = params['audio'][:type].split("/").last
    # name = uuid + '.' + audio_type
    @user = User.find params[:id]
    @user.audio = params['audio']
    @user.save!
    # redirect_to user_path(@user)

    # tempfile = Tempfile.new("audioupload")
    # tempfile.binmode
    # tempfile << request.body.read
    # tempfile.rewind



    respond_to do |format|
      if @user.save
        format.json { head :ok }
      else
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
    # redirect_to user_path(@user)
  end





  #   # File.open("uploads/#{uuid}.#{audio_type}", "w") do |f|
  #   #   f.write(params['audio'][:tempfile].read)
  #   # end
  # end
end
