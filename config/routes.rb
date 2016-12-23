Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"

  devise_for :users, controllers: {registrations: "registrations",
    confirmations: "confirmations"}

  root "static_pages#index"

  resources :news, only: [:show, :index]
  resources :comments, except: :show
  resources :club_requests
  resources :event_requests
  resources :events, only: :show
  resources :likes, only: [:create, :destroy]
  resources :user_events, only: [:create, :destroy]
  resources :ratings, only: :create
  resources :user_clubs, only: [:create, :destroy, :update]
  resources :club_member
  resources :users, only: [:edit, :show, :update]
  resources :albums, only: [:index, :show]
  resources :images
  namespace :management do
    resources :events
    resources :news, except: :show
    resources :albums
    resources :user_clubs
    resources :event_requests
  end
  namespace :admin do
    resources :club_requests
    resources :clubs
    resources :organizations
  end
  resources :organizations, only: :show
  get "list_users" => "users#index"
end
