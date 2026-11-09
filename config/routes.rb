Rails.application.routes.draw do
  resource :session, only: %i[create destroy]
  get "login", to: "sessions#new", as: :new_session
  resources :passwords, only: %i[create edit update], param: :token
  get "password_reset", to: "passwords#new", as: :new_password
  resource :registration, only: %i[create]
  get "registration", to: "registrations#new", as: :new_registration
  get "/auth/:provider/callback", to: "sessions#omniauth"
  root "main#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
