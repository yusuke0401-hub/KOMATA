class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  #フラッシュメッセージ
  add_flash_types :success, :info, :warning, :danger
  
  def counts(user)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_liked_otasuke_messages = user.liked_otasuke_messages.count
    @count_my_komata_messages = user.komata_messages.count
  end
  
  protected
  
  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :password, :password_confirmation])  
   devise_parameter_sanitizer.permit(:sign_up, keys: [:login, :name, :email, :password])
   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :avatar, :avatar_cache, :remove_avatar])
  end
  
end
