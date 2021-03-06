class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :omniauthable, :authentication_keys => [:login]
  
  validates :name, presence: true, uniqueness: { case_sensitive: :false }, length: {maximum: 30 }   
  validates :profile, length: { maximum: 300}
  
  mount_uploader :avatar, AvatarUploader
  
  #komata_message投稿機能
  has_many :komata_messages, dependent: :destroy
  
  #otasuke_message投稿機能
  has_many :otasuke_messages, dependent: :destroy
  
  #otasuke_messageお気に入り機能
  has_many :likes
  has_many :liked_otasuke_messages, through: :likes, source: :otasuke_message
  
  #フォロー機能　
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  
  #フォローメソッド
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  #お気に入りメソッド
  def like(otasuke_message)
    self.likes.find_or_create_by(otasuke_message_id: otasuke_message.id)
  end
  
  def unlike(otasuke_message)
    like = self.likes.find_by(otasuke_message_id: otasuke_message.id)
    like.destroy if like
  end
  
  def liked?(otasuke_message)
    self.liked_otasuke_messages.include?(otasuke_message) 
  end
  
  #メールもしくはパスワードでログイン
  attr_accessor :login
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["name = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end
  
  
 protected         
 
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)
  
    unless user
      user = User.new(name: auth.info.name,
                                email: auth.info.email,
                                provider: auth.provider,
                                uid:      auth.uid,
                                password: Devise.friendly_token[0, 20]
                               )
    end
    user
  end 
  
  def self.dummy_email(auth)  
   "#{auth.uid}-#{auth.provider}@example.com"  
  end 
  
  def self.create_unique_string  
   SecureRandom.uuid  
  end  
  
end
