class OtasukeMessage < ApplicationRecord
  belongs_to :user
  belongs_to :komata_message
  
  validates :content, presence: true, length: { maximum: 500, message: "500文字以内" }

  has_many :likes, dependent: :destroy
  has_many :liked_otasuke_message_users, through: :likes, source: :user

end
