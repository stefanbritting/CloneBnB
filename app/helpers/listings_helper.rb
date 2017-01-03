module ListingsHelper
  def get_listings
    listings_array = Listing.all
  end

  def get_cities
    listing = Listing.all
    cities = []
    listing.each do |listing|
      cities << listing.city unless cities.include?(listing.city)
    end
    return cities
  end

  def get_listings_in
    listings = Listing.where(city: params[:city])
    listings
  end

  def get_listing
    listing = Listing.find(params[:id])
  end
  # for listings#show
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

  # for listings#edit
  def get_uploaded_listings(listing)
    uploads = listing.upload_listings
    if uploads.length > 0
      return uploads # Array of UploadListings
    else
      return ["no image"]
    end
  end
  # end of helper
end
