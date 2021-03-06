class SessionsController < Clearance::SessionsController
  def create_from_omniauth
    # check request.env here facebook send the whole information requested
    #  so first_name and last_name can be also taken from here
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)

      # is the User already exist he will be sign_in
      # if not a new account will be created
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = "/" # can also use root_url is existing
      @notice = "Signed in!"
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      @next = "/"
      @notice = "User created - confirm or edit details"
    end
    sign_in(user)
    redirect_to @next, :notice => @notice
  end
  # end of class
end
