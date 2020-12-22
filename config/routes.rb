Rails.application.routes.draw do
  #rootパス
  root 'pages#index'
  #レビュー
  resources :reviews, :only => [:create]
  #投稿
  resources :posts do
  #いいね
  resources :likes, :only => [:create, :destroy]
  end
  #ユーザー関連
  devise_for :users
  devise_for :views
  resources :users, :only => [:index, :show] 
  #ナビバーの「いいねした投稿」を開くとログインしているユーザーのいいね一覧ページに飛ぶ
  get 'users/:id/likes' => 'users#likes'
  #メッセージ
  resources :messages, :only => [:create]
  #トークルーム
  resources :rooms, :only => [:create, :show]
  #通知
  resources :notifications, :only => [:index]
  #ログイン直後に遷移するページ
  get 'pages/show'
  # ログアウト
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
