class Like < ApplicationRecord
  belongs_to :otasuke_message
  belongs_to :user
  
  validates :user_id, presence: true
  validates :otasuke_message_id, presence: true
end
