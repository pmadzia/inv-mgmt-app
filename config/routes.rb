Rails.application.routes.draw do
  root "main#index"

  resource :session, only: %i[create destroy]
  get "login", to: "sessions#new", as: :new_session

  resources :passwords, only: %i[create edit update], param: :token
  get "password_reset", to: "passwords#new", as: :new_password

  resource :registration, only: %i[create]
  get "registration", to: "registrations#new", as: :new_registration

  get "/auth/:provider/callback", to: "sessions#omniauth"

  resources :users, only: :show
  get  "admin",         to: "admin#index"
  post "admin/block",   to: "admin#block_selected",           as: :block_selected_admin
  post "admin/unblock", to: "admin#unblock_selected",         as: :unblock_selected_admin
  post "admin/promote", to: "admin#promote_selected",         as: :promote_selected_admin
  post "admin/demote",  to: "admin#demote_selected",          as: :demote_selected_admin
  post "admin/delete",  to: "admin#delete_selected",          as: :delete_selected_admin

  get "up" => "rails/health#show", as: :rails_health_check
end
