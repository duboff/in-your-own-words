class AfterSignupController < ApplicationController
  include Wicked::Wizard

  before_action :authenticate_user!

  steps :record_audio, :confirm_profile, :congratulations

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
    # redirect_to after_signup_path(:confirm_profile) and return
  end

  def finish_wizard_path
    user_path(@user)
  end

end
