Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :recruits, only: [:index, :show, :edit, :create, :destroy, :update, :new] do
    resource :favorites, only: [:create, :destroy]
    resources :recruit_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
     resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  resources :messages, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]
end
