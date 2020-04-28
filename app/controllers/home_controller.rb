class HomeController < ApplicationController
  def index
    @otasuke_message_ranking_users = User.find(OtasukeMessage.group(:user_id).order('count(user_id) DESC').limit(3).pluck(:user_id))
  end
end
