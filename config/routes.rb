Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/feed', to: 'pages#feed'
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
  resources :chatrooms, only: [:create, :show, :destroy] do
    resources :messages, only: [:create]
  end
  resources :user_interests, only: [:create, :destroy]
  resources :items, except: [:new, :create]
  resources :messages, except: [:destroy]
  #DONATE THROUGH USER??
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
