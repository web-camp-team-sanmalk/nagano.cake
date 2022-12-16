Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :admins
  devise_for :customers

  namespace :admin do
    get 'homes/top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :sessions, omly: [:new, :create, :destroy]
  end

  scope module: :public do
    get 'homes/top'
    get 'homes/about'
    get 'customers/unsubscribe'
    patch 'customers/withdrawal'
    delete 'cart_items/destroy_all'
    get 'orders/about'
    post 'orders/confirm'
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :orders, only: [:new, :create, :index, :show]
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
