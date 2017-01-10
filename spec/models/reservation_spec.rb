require "rails_helper"

RSpec.describe Reservation, type: :model do
  let(:user) {User.create(email: "stefan.test@web.de", password: "123456")}
  let(:listing) {Listing.create(title: "First Listing", price_per_night: 12)}

  describe "#check_availability" do
    context "When reservations overlap" do
      it "returns false" do
        reservation = Reservation.create(from: "2017-01-10", to: "2017-01-15", user_id: user.id, listing_id: listing.id)
        overlapping_reservation = Reservation.new(from: "2017-01-13", to: "2017-01-17", user_id: user.id, listing_id: listing.id)

        expect(overlapping_reservation.check_availability).to be false
      end
    end
  end
  describe "#get_total_price" do
    it "returns the total price" do
      reservation = Reservation.create(from: "2017-01-10", to: "2017-01-15", user_id: user.id, listing_id: listing.id)
      expect(reservation.get_total_price).to be 60.0
    end
  end
  # end of test
end
