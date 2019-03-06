Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :users, only: [:show, :create, :update, :destroy] do
        resources :toys, only: [:create, :update, :destroy]
        resources :orders, only: [:index]
      end
      resources :sessions, only: [:create, :destroy]
      resources :toys, only: [:index, :show]
    end
  end
  root to: 'home#index'
end
