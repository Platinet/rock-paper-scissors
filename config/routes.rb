Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "games#new"

  resources :games, only: [:new, :show]
  resources :attempts, only: [:create]
end
