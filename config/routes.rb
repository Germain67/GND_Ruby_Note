Rails.application.routes.draw do

  namespace :users do
  get 'invitations/new'
  end

  namespace :users do
  get 'invitations/create'
  end

  namespace :users do
  get 'invitations/edit'
  end

  namespace :users do
  get 'invitations/update'
  end

  resources :epreuves, :matieres

  ######## ROUTES MATIERES

  get 'matieres/index' => 'matieres#index'

  # le as: 'alias' permet de donner un alias, du coup dans tous les fichiers, on pourra accéder à cette méthode grâce à show_article_path
  get 'matieres/show/:id' => 'matieres#show', as: 'show_matiere'

  get 'matieres/new' => 'matieres#new'

  get 'matieres/edit/:id(.:format)' => 'matieres#edit'

  get 'matieres/add_etudiant/:id(.:format)' => 'matieres#add_etudiant', as: 'add_etudiant_matiere'

  get 'matieres/validate_add/:matiere_id(.:format).:user_id(.:format)' => 'matieres#validate_add', as: 'validate_add_matiere'

  get 'matieres/remove_etudiant/:matiere_id(.:format).:user_id(.:format)' => 'matieres#remove_etudiant', as: 'remove_etudiant_matiere'

  get 'matieres/create' => 'matieres#create'

  get 'matieres/update' => 'matieres#update'

  get 'matieres/destroy' => 'matieres#destroy'

  ######### ROUTES EPREUVES

  get 'epreuves/index' => 'epreuves#index'

  get 'epreuves/show/:id(.:format)' => 'epreuves#show', as: 'show_epreuve'

  get 'epreuves/new' => 'epreuves#new'

  get 'epreuves/edit/:id(.:format)' => 'epreuves#edit'

  get 'epreuves/create' => 'epreuves#create'

  get 'epreuves/update' => 'epreuves#update'

  get 'epreuves/destroy' => 'epreuves#destroy'

  ######### ROUTES USERS

  get 'users/index' => 'users#index'

  get 'users/manage_pending' => 'users#manage_pending', as: 'manage_pending'

  get 'users/manage_all' => 'users#manage_all', as: 'manage_all'

  get 'users/show/:id(.:format)' => 'users#show', as: 'show_user'

  delete 'users/destroy/:id(.:format)' => 'users#destroy', as: 'delete_user'

  post 'users/accept/:id(.:format)' =>  'users#accept', as: 'accept_user'



  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  get 'home/index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
