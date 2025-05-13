Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "omniauth_callbacks" }, skip: [ :sessions, :registrations ]

  resources :users, only: [] do
    get "profile", on: :member
  end

  devise_scope :user do
    # if you don't have the skip: [ :sessions, :registrations ] option above, then you need to use the following:
    delete "/logout", to: "authentications#destroy"
    delete "/users/sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  get "home", to: "home#index"
  get "home/index"

  # Defines the root path route ("/")
  # root "posts#index"
  root "home#index"
end
