class ApplicationController < ActionController::Base
     # This is so to say the helper file for add controllers
  include Clearance::Controller
  def main
    # this method should actually be in the controller of the main
    # view file
    @listing = Listing.order(:city).page(params[:page])
    render '/main'
  end
  def allowed?(action, user)
      # array declaring allowed actions for each user role
    customer_actions    = [:new, :create, :edit, :update, :show, :delete]
    moderator_actions   = customer_actions.dup
    moderator_actions  << :verify
    superadmin_actions  = moderator_actions
    access = false
    case user.role
    when "customer"
      access = customer_actions.include?(action)
    when "moderator"
      access = moderator_actions.include?(action)
    when "superadmin"
      access = superadmin_actions.include?(action)
    else
      raise "Error: User role not defined!"
    end
    return access
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    # end of class
end
