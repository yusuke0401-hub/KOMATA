class UsersController < ApplicationController
  before_action :authenticate_user! 
  
  def index
    @users = User.all.page(params[:page]).per(9)
  end

  def show
    @user = User.find(params[:id])
  end
end
