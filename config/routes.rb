Rails.application.routes.draw do
  resources :albums
  resources :images
  get 'user/show'
  # get 'album/index'
  # get 'album/show'

  devise_for :users
  put 'user/:username' => 'user#user_profile_update', as: :user_profile_update
  get 'landing_page/index'
  get 'landing_page/hello'
  get 'page/user_profile_page'
  root 'landing_page#index'
  get 'user/:username' => 'user#show', as: :user_profile
  get 'user/:username/following' => 'user#following', as: :user_following
  get 'user/:username/followers' => 'user#followers', as: :user_followers
  post 'user/:username/edit' => 'user#user_profile_edit', as: :user_edit
  get 'user/:username/mutual_friends/:friend_username' => 'user#mutual_friends', as: :user_mutual_friends
  get '/user/:username/albums' => 'albums#index', as: :album_index_page
  get '/user/:username/new_album' => 'albums#new', as: :album_new_page
  get '/user/:username/albums/:title' => 'albums#show', as: :album_show_page


  resources :friendships

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
