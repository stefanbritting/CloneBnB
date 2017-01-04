class ReservationMailer < ApplicationMailer
  default from: 'thats1.how2.you3@gmail.com' # from this account all emails will be sent
  def new_booking_email(customer, host, reservation)
    @customer = customer
    @host = host
    @url = "/listings/#{reservation.listing.id}/reservations"
    mail(to: host.email, subject: 'New Reservation for your Property')
  end
end
