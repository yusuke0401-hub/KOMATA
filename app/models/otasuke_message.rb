class OtasukeMessage < ApplicationRecord
  belongs_to :user
  belongs_to :komata_message
  
  validates :content, presence: true

  has_many :likes, dependent: :destroy
  has_many :liked_otasuke_message_users, through: :likes, source: :user

end
