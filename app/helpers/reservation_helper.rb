module ReservationHelper
  def get_listing
    listing = Listing.find(params[:listing_id])
  end

  def get_listing2
    listing = Listing.find(params[:id])
  end

  def get_reservation_braintree
    reservation = Reservation.find(params[:braintree][:reservation_id])
  end
  # how long customer rents palce
  def get_total_price
    reservation = get_reservation_braintree
    duration = reservation.to - reservation.from
    total = reservation.listing.fees + (duration * reservation.listing.price_per_night)
    total.to_f
  end

  def payed?(reservation)
    sum = 0
    reservation.payments.each do |p|
      sum = sum + p.amount
    end
    return true if sum >= reservation.get_total_price
    false
  end
  # end of Module
end
