Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  get 'home/index'

  resources :projects, only: :create
end
