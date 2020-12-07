Rails.application.routes.draw do
  get 'posts/create'
  get 'posts/new'
  get 'posts/index'
  get 'post/new'
  get 'post/index'
  devise_for :users
  devise_for :views
  root 'pages#index'
  get 'pages/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
