WeatherRooster::Application.routes.draw do

  root :to => 'home#status', :constraints => { :subdomain => 'status' }
  # eg status.weatherrooster.com/about redirects to weatherrooster.com/about
  #   http://stackoverflow.com/a/7352878/283398
  match '(*any)' => redirect { |p, req| req.url.sub('status.', '') }, :constraints => { :host => /^status\./ }

  resources :weather_statuses, :only => [:index, :show]

  resources :current_forecasts, :only => [:index, :show]

  resources :cities, :only => [:index, :show]

  resources :weather_records, :only => [:index, :show]

  resources :weather_services, :only => [:index, :show]

  resources :users, :only => [:index, :show]

  get "home/thank_you"
  get 'city/:city' => 'home#main'
  get "home/landing"
  get "home/main"
  get "status"=> "home#status"
  get "about" => "home#about"
  get "contact" => "home#contact"
  get "city_details" => "home#city_details"
  get "city/:city/details" => "home#city_details"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'home#main'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
