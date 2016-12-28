module ListingsHelper
  def get_listings
    listings_array = Listing.all
  end

  def get_listing
    listing = Listing.find(params[:id])
  end
  # end of helper
end
