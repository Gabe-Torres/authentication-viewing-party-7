Rails.application.routes.draw do
  root 'welcome#index'
  # resources :users, only: [:show], as: 'dashboard' 
  get '/dashboard', to: 'users#show', as: 'dashboard'
  
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'
  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  get "/logout", to: "users#logout"

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end
end
