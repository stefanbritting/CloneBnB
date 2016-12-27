class Tag < ActiveRecord::Base
  has_many :listing, through: :listing_tags
  has_many :listing_tags, :dependent => :destroy
end
