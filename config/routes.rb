Rails.application.routes.draw do
  get 'messages/create'
  #レビュー
  resources :reviews, :only => [:create]
  #投稿
  resources :posts do
    #いいね
    resources :likes, :only => [:create, :destroy]
  end
  get 'users/:id/likes' => 'likes#index'
  #ユーザー
  devise_for :users
  devise_for :views
  resources :users, :only => [:index, :show] 
  #メッセージ
  resources :messages, :only => [:create]
  #トークルーム
  resources :rooms, :only => [:create, :show]
  root 'pages#index'
  get 'pages/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
