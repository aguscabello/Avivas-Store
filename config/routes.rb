Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  devise_for :users

  Rails.application.routes.draw do
    resources :products do
      member do
        get :edit_stock   # Ruta para mostrar el formulario de edición de stock
        patch :update_stock # Ruta para procesar la actualización del stock
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html



  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "products#index"
end
