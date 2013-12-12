YelpClone::Application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]

  resources :businesses
  resources :categories, only: [:index]
  resource :profile, only: [:show, :edit, :update]
  resource :search
  # match "profile" => "user#profile"
  # match "profile_bio" => "profile#profile_bio", via: :get
  # match "profile_bio" => "user#profile_bio", via: :put

  root to: "profiles#show"
end