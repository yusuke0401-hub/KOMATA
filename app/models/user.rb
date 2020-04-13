class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :omniauthable, :authentication_keys => [:login]
  
  validates :name, presence: true, uniqueness: { case_sensitive: :false }, length: {maximum: 30 }   
  validates :profile, length: { maximum: 300}
  
  attr_accessor :login
  mount_uploader :avatar, AvatarUploader
  
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
