class ListingsController < ApplicationController
  # CRUD methods
  def new
    render '/listings/new'
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    @listing.verification = false
      # ***throws error online if price_per_night is not provided***
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

  def find_journey
    @listings = Listing.search_by_city(params[:destinations][:city])
    price_from = price_limits(params[:destinations][:price_from]).to_i # "".to_i => 0
    price_to = price_limits(params[:destinations][:price_to])
    price_to = 10**8 if price_to == "" || price_to == 0
    # condition ? if_true : if_false
    @listings = @listings.price_range(price_from, price_to)
    render '/destinations'
  end
################################################
    private

  def price_limits(price)
    return 0 if price == ""
    price
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :country, :city,
    :zip_code, :street_address, :price_per_night, :fees)
  end

  # end of class
end
