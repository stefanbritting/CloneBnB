# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  def welcome_email
    ReservationMailer.new_booking_email(User.find(14), User.find(15), Reservation.find(7) )
  end
end
