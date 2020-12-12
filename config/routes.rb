Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :recruits, only: [:index, :show, :edit, :create, :destroy, :update, :new] do
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resources :favorites, only: [:create, :destroy, :index]
    resources :recruit_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    get 'favorites' => 'users#favorites', as: 'favorites'
  end
  resource :relationships, only: [:create, :destroy]
  resources :messages, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]
end
