class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :tags, through: :listing_tags
  has_many :listing_tags :dependent => :destroy
end
