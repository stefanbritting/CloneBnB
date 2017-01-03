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
     @listing.update(listing_params)
      # this wont work with multiple true!
      # saving the image
    @listing.upload_listings.create(image: params[:listing][:image]) if  params[:listing][:image] # not nil
    if @listing.save
      redirect_to "/listings/#{@listing.id}"
    else
      render "/listings/#{@listing.id}/edit"
    end
  end

  def verify
    flash_message = "Verification was not successful! No Permission!"
    if allowed?(:verify, current_user)
      # default of verification is false
      # default of checkbox is unchecked
      # so it will always change to the oposite (if checked => true)
      @listing = Listing.find(params[:id])
      @listing.verification = not(@listing.verification)
      if @listing.save
        flash_message = "Verification was successful!"
      end
    end
    flash[:notice] = flash_message
    redirect_to "/listings/#{params[:id]}"
  end

  def reservations
    render '/listings/reservations'
  end

  def find
    render '/listings/find'
  end

  def find_in
    render '/listings/city'
  end
################################################
    private

  def listing_params
    params.require(:listing).permit(:title, :description, :country, :city,
    :zip_code, :street_address, :price_per_night, :fees)
  end

  # end of class
end
