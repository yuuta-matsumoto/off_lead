Rails.application.routes.draw do
  #rootパス
  root 'pages#top'
  #フォロー
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
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
  resources :users, :only => [:index, :show] do
    #フォロー関連のルーティング を追加
    get :following, :follower, on: :member
  end
  #ナビバーの「いいねした投稿」を開くとログインしているユーザーのいいね一覧ページに飛ぶ
  get 'users/:id/likes' => 'users#likes'
  #メッセージ
  resources :messages, :only => [:create]
  #トークルーム
  resources :rooms, :only => [:create, :show]
  #ログイン直後に遷移するページ
  get 'pages/show'
  # ログアウト
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
