class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  has_many :payments

  def check_availability
    listing = Listing.find(self.listing_id)
    all_reservations = listing.reservations
    reservation_dates = [self.from, self.to]
    carlendar = []
    temp_reservation_dates = []
      # Collection of reservations.
      # will be skipped if collection is empty
    all_reservations.each do |r|
      temp_reservation_dates << r.from
      temp_reservation_dates << r.to
      carlendar << temp_reservation_dates
    end
    return not(bookings_overlapp?(carlendar, reservation_dates))
  end
  def get_total_price
    duration = self.to - self.from
    self.listing.fees = 0 unless self.listing.fees
    total = self.listing.fees + (duration * self.listing.price_per_night)
    total.to_f
  end
    private
      # returns true if overlapping
  def bookings_overlapp?(carlendar, dates) # dates[0]=from; dates[1]=to
    carlendar.each do |c| # c[0]=from; c[1]=to
        # on arrival/depature date another reservation can end/start
        # different checkin and checkout times
      booked_range = (c[0] + 1)..(c[1]-1)
      return true if booked_range === dates[0] || booked_range === dates[1]
    end
    return false
  end
  # end of class
end
