Rails.application.routes.draw do

  root 'users/homes#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/registrations'
  }

  namespace :users do
    resources :users, only:[:show, :edit, :update, :destroy]
    resources :posts, only:[:show, :new, :create, :edit, :update, :destroy] do
      resource :comments, only:[:create, :destroy]
      resource :favorites,only:[:create, :destroy]
      get :favorites, on: :collection
    end
    resources :scenes, only:[:show]
    resources :inquiry, only:[:new, :create]
    get 'users/inquiry' => 'inquiries#complete', as: 'inquiry_complete'
    get 'homes/top' => 'homes#top', as: 'user_top'
    get 'homes/help' => 'homes#help', as: 'user_help'
    get 'search' => 'searches#search', as: 'user_search'
    #↓フォローする、フォローを外す動作
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
    #↓フォロー・フォロワー一覧を見る
    get 'users/:id/following' => 'relationships#following', as: 'following'
    get 'users/:id/followers' => 'relationships#followers', as: 'followers'
  end

  devise_for :admins, skip: :all
    devise_scope :admin do
      get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
      post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
      delete 'admins/sign_out' => 'admins/sessions#destroy',as: 'destroy_admin_session'
    end

  namespace :admins do
    resources :posts, only:[:index, :show, :destroy]
    resources :scenes, only:[:index, :create, :destroy]
    resources :users, only:[:index]
    patch 'users/:id' => 'users#suspend',as: 'suspend_user'
    get 'top' => 'homes#top',as: 'top'
    get 'search' => 'searches#search',as: 'search'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
