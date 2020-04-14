class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_user, only: [:show, :followings, :followers]
  
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
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
