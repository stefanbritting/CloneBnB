class UsersController < Clearance::UsersController
    # will redirect a not login user when triying
    # to access actions within the UserController
  before_action :require_login

  def show
    render '/users/show'
  end
private
  # Overriding method from clearance gem in order to
  # create user with more attrbutes
  # than just email and password
  def user_params

  end
  #  end of controller
end
