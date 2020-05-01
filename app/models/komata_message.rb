class KomataMessage < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 500, message: "500文字以内" }

  
  #otasuke_message投稿機能
  has_many :otasuke_messages, dependent: :destroy
  
  
  mount_uploader :image, ImageUploader

end
