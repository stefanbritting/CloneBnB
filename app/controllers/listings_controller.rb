class ListingsController < ApplicationController
  # CRUD methods
  def new
    render '/listings/new'
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    @listing.verification = false
    if @listing.save
      redirect_to "/listings/#{@listing.id}"
    else
      render '/listings/new'
    end
  end

  def edit
    listing = Listing.find(params[:id])
    if current_user.id == listing.user_id
      render '/listings/edit'
    else
      redirect_to "/listings/#{params[:id]}"
    end
  end

  def update
    @listing = Listing.find(params[:id])
    strong_params = listing_params

    @listing.title            = strong_params[:title]  unless strong_params[:title] == ""
    @listing.description      = strong_params[:description] unless strong_params[:description] == ""
    @listing.country          = strong_params[:country] unless strong_params[:country] == ""
    @listing.city             = strong_params[:city] unless strong_params[:city] == ""
    @listing.zip_code         = strong_params[:zip_code] unless strong_params[:zip_code] == ""
    @listing.street_address   = strong_params[:street_address] unless strong_params[:street_address] == ""
    @listing.price_per_night  = strong_params[:price_per_night] unless strong_params[:price_per_night] == ""
    @listing.fees             = strong_params[:fees] unless strong_params[:fees] == ""
    if @listing.save
      redirect_to "/listings/#{@listing.id}"
    else
      render "/listings/#{@listing.id}/edit"
    end
  end

  def verify
    # default of verification is false
    # default of checkbox is unchecked
    # so it will always change to the oposite (if checked => true)
    @listing = Listing.find(params[:id])
    @listing.verification = not(@listing.verification)
    if @listing.save
      redirect_to "/listings/#{@listing.id}"
    else
      render "/listings/#{@listing.id}/", notice: "Verification not successful!"
    end
  end
################################################
    private

  def listing_params
    params.require(:listing).permit(:title, :description, :country, :city,
    :zip_code, :street_address, :price_per_night, :fees)
  end
  # end of class
end
