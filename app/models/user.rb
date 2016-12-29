class User < ActiveRecord::Base
  require 'securerandom'
  include Clearance::User
  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy
    # the role coloumn is integer but their value will be concerted
    # the the role: [:symbols] according to their position (0,1,2)
    # the ActiveREcord::Enum model further adds nice methods
  enum role: [:customer, :moderator, :superadmin]
    # for image uploads :avatar(=column name)
  mount_uploader :avatar, AvatarUploader
###########################################
  # methods
  def self.create_with_auth_and_hash(authentication, auth_hash)
     # include more user info. auth_hash needs to contain public_profile
    user = User.new(email: auth_hash["extra"]["raw_info"]["email"] )
    # more info
    user.remember_token = SecureRandom.hex(3)
    user.authentications << (authentication)
    # Problem: user.password (method from clearance) will raise error
    # although column 'encrypted_password' can be null
    # USING FACEBOOK log in. no need to save a password!
    user.password = "notgoodsolution"
    user.save
  end

  # override provide_password method here

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
  # end of class
end
