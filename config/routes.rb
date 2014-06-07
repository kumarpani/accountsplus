Accountsplus::Application.routes.draw do

  get "taxes/index"

  post "service_taxes/index"
  get "service_taxes/index"

  post "payments/index"
  get "payments/index"

  post "tds/index"
  get "tds/index"

  post "activity/index"
  get "activity/index"

  get "incoming_service_taxes/print"
  get "tds/print"
  get "ledgers/print"
  get "service_taxes/print"
  get "payments/print"
  get "item_details/print"


  post "quotations/duplicate"
  post "quotations/markAsPaymentsFullyReceived"

  get "backup/index"
  get "backup/backup_data"


  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :payments
  resources :clients do
    resources :ledgers, only: :index
  end
  resources :quotations do
    resources :item_details
  end
  resources :dashboard, only: :index
  resources :calendar, only: :index

  resources :incoming_service_taxes


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
