class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_otasuke_message
  
  def create
    liked = current_user.like(@otasuke_message)
    
    if liked.save 
       redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'ユーザーのフォロー解除に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    liked = current_user.unlike(@otasuke_message)
    if liked.destroy
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'ユーザーのフォロー解除に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def set_otasuke_message
    @otasuke_message = OtasukeMessage.find(params[:otasuke_message_id])
  end
end

    