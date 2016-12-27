class User < ActiveRecord::Base
  require 'securerandom'
  include Clearance::User
  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
     # include more user info. auth_hash needs to contain public_profile
    user = User.create(email: auth_hash["extra"]["raw_info"]["email"] )
    # more info
    user.remember_token = SecureRandom.hex(3)
    user.authentications << (authentication)
    byebug
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
  # end of class
end
