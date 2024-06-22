Rails.application.routes.draw do
  resources :save_user_ghrepos, only: [:create], controller: 'repo'
  get 'get_users', to: 'user#get_users'
  get 'get_users/:username', to: 'user#get_user'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
