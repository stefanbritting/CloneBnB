class ReservationMailer < ApplicationMailer
  def booking_email(customer, host, reservation_id)
    @url  = 'http://example.com/login' # our email account
    mail(to: host.email, subject: 'New Reservation for you Property')
  end
end
