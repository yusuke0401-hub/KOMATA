class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_user, 
  only: [:show, :followings, :followers, :liked_otasuke_messages, :my_komata_messages]
  
  def index
    @users = User.all.page(params[:page]).per(9)
  end

  def show
    counts(@user)
  end
  
  def followings
    @followings = @user.followings.page(params[:page])
  end
  
  def followers
    @followers = @user.followers.page(params[:page])
  end
  
  def liked_otasuke_messages
    @liked_otasuke_messages = @user.liked_otasuke_messages.page(params[:page])
  end
  
  def my_komata_messages
    @my_komata_messages = @user.komata_messages.order('created_at DESC').page(params[:page])
  end
  
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
