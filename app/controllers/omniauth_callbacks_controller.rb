class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def linkedin
    @user = User.find_for_oauth(request.env["omniauth.auth"])
    provider = @user.provider

    if @user.persisted?
      sign_in @user
      # sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => provider.capitalize) if is_navigational_format?
      redirect_to charts_path
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
