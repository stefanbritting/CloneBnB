# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

70.times do
  @listing = Listing.new()
  @listing.description      = FFaker::Book.description
  @listing.country          = "Germany"
  @listing.city             = FFaker::AddressDE.city
  @listing.zip_code         = FFaker::AddressDE.zip_code
  @listing.street_address   = FFaker::AddressDE.street_address
  @listing.title            = "Nice place to stay in " + @listing.city
  @listing.price_per_night  = rand(150)
  @listing.fees             = rand(50)
  @listing.user_id          = 14
  @listing.save
end
