Rails.application.routes.draw do
  #レビュー
  resources :reviews, :only => [:create]
  #投稿
  resources :posts
  #ユーザー
  devise_for :users
  devise_for :views
  get 'users/index'
  get 'users/show'
  
  root 'pages#index'
  get 'pages/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
