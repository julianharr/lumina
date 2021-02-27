Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  root to: 'pages#home'

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
  #DONATE THROUGH USER??
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
