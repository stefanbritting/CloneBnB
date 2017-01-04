class ReservationController < ApplicationController
  def new
    render 'reservation/new'
  end
  def create
    params[:reservation][:user_id] = current_user.id
    params[:reservation][:listing_id] = params[:listing_id]
    reservation = Reservation.new(reservation_params)
    if reservation.check_availability
      if reservation.save
        flash[:notice] = "Reservation successful"
        ReservationMailer.new_booking_email(User.find(reservation.user_id), User.find(reservation.listing.user_id), reservation).deliver_now
        redirect_to "/listings/#{params[:listing_id]}"
      else
        flash[:notice] = "Reservation could not be save! Please checkout your date format!"
        redirect_to "/listings/#{params[:listing_id]}/reservation/new"
      end
    else
      flash[:notice] = "Place already booked for selected period! Please choose different dates."
      redirect_to "/listings/#{params[:listing_id]}/reservation/new"
    end
  end
    private
  def reservation_params
      params.require(:reservation).permit(:from, :to, :user_id, :listing_id)
  end
    # end of class
end
