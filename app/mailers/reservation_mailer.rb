class ReservationMailer < ApplicationMailer
  default from: 'notifications@example.com' # from this account all emails will be sent
  def new_booking_email(customer, host, reservation_id)
    @customer = customer
    @host = host
    @reservation_id = reservation_id
    mail(to: host.email, subject: 'New Reservation for you Property')
  end
end
