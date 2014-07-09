class AfterSignupController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_user!

  steps :record_audio, :confirm_profile

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.update! params[:user].permit(:cv) if params[:cv]
    render_wizard @user
  end

  def upload
    # puts params.inspect
    @user = current_user
    @user.audio = params['audio']
    @user.save!
    respond_to do |format|
      if @user.save
        format.json { head :ok }
      else
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
    # redirect_to user_path(@user)
  end

  def finish_wizard_path
    user_path(@user)
  end

end
