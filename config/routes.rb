Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/show'
  #
  devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks"}
  # User redirected to feed page upon sign in
  get '/user' => "pages#feed", :as => :user_root

  root to: 'pages#home'
  get '/about', to: 'pages#about'

  # For Redis and ActionCable
  mount ActionCable.server => '/cable'
  get '/feed_partial', to: 'pages#ajax'
  get '/feed', to: 'pages#feed'
  get '/interests', to: 'pages#interests'
  get '/dashboard', to: 'pages#dashboard'
  get 'user/:id', to: 'users#show', as: :profile
  resources :events, only: [:index, :show] do
    resources :chatrooms, only: [:create]
  end
  resources :charities, only: [:index, :show] do
    resources :donates, only: [:new, :create]
  end
  resources :wishlists, only: [:show] do
    resources :items, only: [:new, :create]
  end

  resources :chatrooms, only: [:index, :show, :create] do
    resources :messages, only: [:show, :create]

  end

  resources :user_interests, only: [:create, :destroy]
  resources :interests, only: [:create]
  resources :items, except: [:new, :create]
  resources :messages, except: [:destroy]
  resources :friends, only: %i[index create]
  resources :statuses, only: :create


  post '/friends/add' => 'friends/add'
  post '/friends/reject' => 'friends/reject'
  post '/friends/remove' => 'friends/remove'
  post '/friends/delete' => 'friends/delete'
  post '/friends/block' => 'friends/block'
  # get '/friends/search' => 'friends/search'
  # post '/friends/search' => 'friends/search'
  #DONATE THROUGH USER??
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
