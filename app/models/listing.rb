class Listing < ActiveRecord::Base
  include PgSearch
  belongs_to :user
  has_many :tags, through: :listing_tags
  has_many :listing_tags, :dependent => :destroy
  has_many :upload_listings, :dependent => :destroy
  has_many :reservations, :dependent => :destroy
  scope :city, ->(city) {where("city = ?",city) if city.present?}
  scope :price_range, ->(from, to) {where("price_per_night >= ? AND price_per_night <= ?",from, to)}
  pg_search_scope :search_by_city, :against => :city
end
