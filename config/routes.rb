Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
    # remove the controller in order to point to the UserController
    # resources :users, only: [:create] will do:
    # post "/users"
  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
  resources :users, only: [:edit, :update]
  resources :listings, only: [:show, :new, :create, :edit, :update] do
    resources :reservation, only: [:show, :new, :create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

    # User routes
  get "/users/:id" => "users#show"
  get "/users/:id/reservations" => "users#reservations"
    # Further Listing routes
  post "listings/:id/verify" => "listings#verify"
  get "/listings/:id/reservations" => "listings#reservations"
  get "/listings/find/place" => "listings#find", as: "find_listings"
  get "/listings/find/:city" => "listings#find_in", as: "find_listing_in"
    # Facebook Omniauth routes
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
    # delete upload_listing (which is image of a listing)
  delete "/upload_listings/:id" => "upload_listings#destroy"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
    root 'application#main'
   # root :to => "users#new",
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
