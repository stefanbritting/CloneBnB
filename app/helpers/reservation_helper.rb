module ReservationHelper
  def get_listing
    listing = Listing.find(params[:listing_id])
  end

end
