module ListingsHelper
  def get_listings
    listings_array = Listing.all
  end

  def get_listing
    listing = Listing.find(params[:id])
  end

  def get_upload_listing_urls(listing)
    uploads = listing.upload_listings
    if uploads.length > 0
      urls = []
      uploads.each do |u|
        urls << u.image.url
      end
      return urls # Array of UploadListings
    else
      return ["/uploads/upload_listing/alteriantive/alt_house.png"]
    end
  end
  # end of helper
end
