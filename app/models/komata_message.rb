class KomataMessage < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true
  
  #otasuke_message投稿機能
  has_many :otasuke_messages, dependent: :destroy
  
  
  mount_uploader :image, ImageUploader

end
