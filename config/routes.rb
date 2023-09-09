Rails.application.routes.draw do
  root 'welcome#index'
  # resources :users, only: [:show], as: 'dashboard' 
  get '/dashboard', to: 'users#show', as: 'dashboard'
  
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  # get '/movies/:id', to: 'movies#show', as: 'movie'
  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  get "/logout", to: "users#logout"
  # get '/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new', as: 'new_viewing_party'
  # post '/movies/:movie_id/viewing_parties', to: 'viewing_parties#create', as: 'viewing_parties'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end

  resources :movies, only: [:show] do
    resources :viewing_parties, only: [:new, :create]
  end
end
