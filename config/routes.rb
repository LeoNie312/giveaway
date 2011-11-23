Giveaway::Application.routes.draw do

#### resources routes ####
  resources :wishes, :only => [:new, :create, :destroy] do
    post 'connect', :on => :member
  end

  resources :sessions, :only => [:new, :create, :destroy]

  resources :users do
    member do
      post 'checkin', :to => 'users#checkin' 
      get 'offshelf_items', :to => 'users#offshelf_items' 
    end
  end
  
  resources :categories, :only => [:show]
  # match "/categories/:id", :to => "categories#show"
  
  resources :items, :only => [:show, :new, :create, :update, :destroy] do
    collection do
      get 'search', :to => 'items#search_items' # search_items_path
    end
    
    member do
      put 'transfer', :to => 'items#transfer'
      put 're_onshelf', :to => 'items#re_onshelf'
    end
  end
  
#### resources routes ####

  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/checkin', :to => 'users#checkin', :via => :post
  match '/connect', :to => 'wishes#connect', :via => :post
  
  root :to => "pages#home"
  
  match '/about' => "pages#about"
  
  match '/contact' => "pages#contact"
  
  match '/users/:id/items_wishes', :to => 'users#items_wishes', :as => 'items_wishes'
  
  get 'error' => "pages#error"
  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
