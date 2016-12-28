module UsersHelper
  def get_user_name
        # params are automatically passed to the function
    owner =  User.find(Listing.find(params["id"]).user_id)
    if owner.first_name
      name = owner.first_name + " " + owner.last_name
    elsif owner.last_name
      name = owner.last_name
      byebug
    else
      return owner.email
    end
    return name
  end
  # end of module
end
