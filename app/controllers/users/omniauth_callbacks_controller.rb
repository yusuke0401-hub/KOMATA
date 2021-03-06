class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_for(:google)
  end
  
  def callback_for(provider)
    @user = User.find_for_google(request.env["omniauth.auth"])
    
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      
      @user.skip_confirmation!
      @user.save!
      
      redirect_to new_user_registration_url
    end
  end
  
  def failure
    redirect_to root_path
  end
  
end
