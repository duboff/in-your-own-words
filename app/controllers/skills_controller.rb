class SkillsController < ApplicationController
  def update
    @user = current_user
    # @user.audio = params['audio']
    skill = Skill.find params[:id]

    @user.skills.delete(skill)
    @user.save!

    respond_to do |format|
      if @user.save
        format.json { head :ok }
        format.html {render :show}
      else
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
    # redirect_to user_path(@user)
  end
end
