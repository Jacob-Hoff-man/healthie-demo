Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  resources :providers do
    get 'clients', to: 'provider_client_plans#provider_clients'
    get 'journals', to: 'journals#index'
  end

  resources :clients do
    resources :journals, shallow: true
    get 'providers', to: 'provider_client_plans#client_providers'
  end

  resources :plans, param: :name do
    get 'provider_client_plans', to: 'provider_client_plans#plan_provider_client_plans'
  end

  resources :provider_client_plans, only: [:create] do
    delete ':provider_id/:client_id/:plan_name', action: :destroy, on: :collection
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
