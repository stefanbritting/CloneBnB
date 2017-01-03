module ReservationHelper
  def get_listing
    listing = Listing.find(params[:listing_id])
  end
  def get_listing2
    listing = Listing.find(params[:id])
  end
end
