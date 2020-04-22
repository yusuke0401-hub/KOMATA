class OtasukeMessagesController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def index
    @otasuke_messages = @komata_message.otasuke_messages.order('created_at DESC').page(params[:page])
  end
  
  def create
    komata_message = KomataMessage.find(params[:komata_message_id])
    @otasuke_message = komata_message.otasuke_messages.build(otasuke_message_params)
    @otasuke_message.user_id = current_user.id
    
    if @otasuke_message.save
      flash[:success] = "otasukeメッセージを投稿しました。"
      redirect_back(fallback_location: root_path)
    else
      @otasuke_messages = current_user.otasuke_messages.order('created_at DESC').page(params[:page])
      flash[:danger] = "otasukeメッセージの投稿に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    @otasuke_message.destroy
    flash[:success] = 'otasukeメッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def otasuke_message_params
    params.require(:otasuke_message).permit(:content, :name)
  end
  
  def correct_user
    @otasuke_message = current_user.otasuke_messages.find_by(id: params[:id])
    unless @otasuke_message
      redirect_to root_url
    end
  end
end
