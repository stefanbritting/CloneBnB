module UsersHelper
  # get user_name in Listing
  def get_owner_name
        # params are automatically passed to the function
    owner =  User.find(Listing.find(params["id"]).user_id)
    if owner.first_name
      name = owner.first_name + " " + owner.last_name
    elsif owner.last_name
      name = owner.last_name
    else
      return owner.email
    end
    return name
  end

  def get_listing_owner
    @user = User.find(Listing.find(params[:id]).user_id)
  end
  # end of module
end
