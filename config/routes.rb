YelpClone::Application.routes.draw do
  resources :users do
    get "add_photo" => "photos#new"
    get "photos" => "photos#show"
  end

  resource :session, only: [:new, :create, :destroy]

  resources :businesses do
    match "writeareview" => "reviews#new"
    get "add_photo" => "photos#new"
    get "photos" => "photos#show"
  end

  resources :photos, only: [:create]

  resources :reviews, except: [:new]
  resources :categories, only: [:index]
  resource :profile, only: [:show, :edit, :update]
  resource :search

  # resources :reviews, only : [:new]
  # match "writeareview" => "reviews#new"
  #"writeareview/biz/:id"
  # match "profile" => "user#profile"
  # match "profile_bio" => "profile#profile_bio", via: :get
  # match "profile_bio" => "user#profile_bio", via: :put

  root to: "profiles#show"
end