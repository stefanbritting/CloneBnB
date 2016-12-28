class ApplicationController < ActionController::Base
  include Clearance::Controller
  def main
    @listing = Listing.all
    render '/main'
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
