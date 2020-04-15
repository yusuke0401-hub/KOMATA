class KomataMessagesController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def index
    @komata_messages = KomataMessage.all.order('created_at DESC').page(params[:page])
  end
  
  def new
    @komata_message = KomataMessage.new
  end 
  
  def create
    @komata_message = current_user.komata_messages.build(komata_message_params)
    
    if @komata_message.save
      flash[:success] = "メッセージを投稿しました。"
      redirect_to komata_messages_path
    else
      @komata_messages = current_user.komata_messages.order('created_at DESC').page(params[:page])
      flash[:danger] = "メッセージの投稿に失敗しました。"
      render "home/index"
    end
  end
  
  def destroy
    @komata_message.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def komata_message_params
    params.require(:komata_message).permit(:content, :image)
  end
  
  def correct_user
    @komata_message = current_user.komata_messages.find_by(id: params[:id])
    unless @komata_message
      redirect_to root_url
    end
  end
end
