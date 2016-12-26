class User < ActiveRecord::Base
  include Clearance::User
  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
     # last_name: auth_hash["last_name"]
     # email: auth_hash["extra"]["raw_info"]["email"]
     # check the input auth_hash
     byebug
    user = Authentication.create(email: auth_hash["email"] )
    user.authentications << (authentication)
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
  # end of class
end
