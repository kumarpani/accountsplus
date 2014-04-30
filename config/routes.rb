AVCreations::Application.routes.draw do
  resources :incoming_service_taxes
  resources :tasks

  get "item_details/print"

  post "service_taxes/index"
  get "service_taxes/index"

  get "taxes/index"
  post "tds/index"
  get "tds/index"


  post "activity/index"
  get "activity/index"

  get "print_ledger/index"
  get "print_service_taxes/index"
  get "print_incoming_service_taxes/index"
  get "print_tds/index"


  post "quotations/duplicate"
  post "quotations/markAsPaymentsFullyReceived"

  devise_for :users

  resources :payments
  resources :clients do
    resources :ledgers, only: :index
  end
  resources :quotations do
    resources :item_details
    resources :print_quotations, only: :index
  end
  resources :dashboard, only: :index
  resources :calendar, only: :index
  resources :tasks, only: :index

  root 'dashboard#index'

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
