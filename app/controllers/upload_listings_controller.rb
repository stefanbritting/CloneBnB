class UploadListingsController < ApplicationController
    # deleteing uploaded images from postgresql db AND Amazon Web server
  def destroy # not implemented yet
      listing = Listing.find(UploadListing.find(params[:id]).listing_id)
      image = UploadListing.find(params[:id])
      image.destroy
      redirect_to "/listings/#{listing.id}"
  end
end
