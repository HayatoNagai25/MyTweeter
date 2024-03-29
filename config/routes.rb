Rails.application.routes.draw do
  get "about", to: "about#index"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  get "tweets", to: "tweets#index"

  get "profile", to: "profile#index"

  resources :tweets
  resources :relationships, only: [:create, :destroy]
  resources :customers do
    member do
      get :following, :followers
    end
  end

  root to: "main#index"

  post '/customers/:id/follow', to: "customers#follow", as: "follow_customer"
  post '/customers/:id/unfollow', to: "customers#unfollow", as: "unfollow_customer"
end