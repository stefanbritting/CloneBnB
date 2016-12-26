# to integrate Omniauth Facebook login
# Initialize Omniauth as a middleware
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV["FACEBOOK_APP_SECRET"]
end
