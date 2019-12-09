Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  # posts
  resources :posts

  # users
  resources :users, only: [:index, :show]

  # likes
  resources :likes, only: [:create, :destroy]

  # comments
  resources :comments, only: [:create]
  
  root to: 'posts#index'
end
