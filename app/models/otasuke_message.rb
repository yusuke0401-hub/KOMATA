class OtasukeMessage < ApplicationRecord
  belongs_to :user
  belongs_to :komata_message
  
  validates :content, presence: true

end
