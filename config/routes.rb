Timetrak::Application.routes.draw do |map|
  get "user_preferences/edit"

  post "user_preferences/update"

  resources :invoices do
    collection do
      post :list_action
    end
    member do
      get :send_invoice
    end 
  end

  devise_for :users, :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  resources :activities do
    collection do
      get :calendar
      post :list_action
    end
  end
  
  resources :invoice_activities do
    collection do
      post :list_action
    end
  end

  resources :list_values do
    collection do
      post :sort
    end
  end

  resources :lists

  resources :projects do
    collection do
      post :list_action
    end
  end

  resources :clients do
    collection do
      post :list_action
    end
  end
  
  match "lists/values/:list_name" => "lists#values"
  
  root :to => "invoice_activities#index"
  

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
