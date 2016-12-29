class UsersController < Clearance::UsersController
    # will redirect a not login user when triying
    # to access actions within the UserController
   before_action :require_login
      # Logical, because other wise noone could
      # send a post request for creating an account
   skip_before_action :require_login, only: [:create, :new], raise: false

  def show
    render '/users/show'
  end
    # controller for post "/users" request
  def create
    @user = User.new(user_from_params)
    @user.role = 0
      # roles:
      # 0 = customer; 1 = moderator; 2 = superadmin

      # actions can respond differently
      # to various request formats being sent
    respond_to do |format|
      if @user.save
        format.html {
          sleep 1
          render template: "users/new"
        }
        format.js {
          sign_in @user
          redirect_back_or url_after_create
        }

      else
        format.html {render template: "users/new"}
        format.js {} # automatically render create.js.erb (rails magic)
      end
    end
    # end of create
  end

  def edit
    render '/users/edit'
  end
  def update
    strong_params = user_from_params
    @user = User.find(params[:id])
    strong_params.each do |attribute| # ["first_name", "Hans"]
      # picture upload will be handled afterwards
      next if attribute[0] == "avatar"
      change_attributes!(attribute, strong_params, @user)
    end
    byebug
    uploader = AvatarUploader.new
    uploader.store!(strong_params[:avatar])
    byebug
    if @user.save
      flash[:notice] = "Changes successfully saved!"
    end
    render '/users/show'
  end
private
  # Overriding method from Clearance gem in order to
  # create user with more attrbutes
  # than just email and password
  def user_from_params
    params.require(:user).permit(:first_name, :last_name, :gender,
     :email, :password, :avatar)
  end

  def change_attributes!(attr, strong_params, user)
    attribute = attr[0].to_sym
    byebug
    user[attribute] = strong_params[attribute]  unless strong_params[attribute] == ""
  end
  #  end of controller
end
