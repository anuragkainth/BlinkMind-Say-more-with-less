Rails.application.routes.draw do
  get "likes/create"
  get "likes/destroy"
  get "password_resets/new"
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  root "sessions#new"

  # Authentication
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  # Signup
  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"

  # Home Feed
  get "/home", to: "posts#index", as: "home"

  # Resources for users and posts
  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:new, :create, :index] do
    resource :like, only: [:create, :destroy]
  end

  # Friendship routes
  resources :friendships, only: [:create, :update, :destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]

  # Friends pages
  get '/friends',         to: 'friends#index',   as: 'friends'
  get '/friends/pending', to: 'friends#pending', as: 'pending_friends'
  get '/friends/search',  to: 'friends#search',  as: 'search_friends'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
    
end
