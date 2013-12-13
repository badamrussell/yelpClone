YelpClone::Application.routes.draw do


  #resources :business_photos, controller:"photo_details" , as: "business_photos"


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

  resources :photos, only: [:create] do
    get "edit_details" => "photo_details#edit"
    put "details", controller: "photo_details"
    post "details" => "photo_details#create"
  end


  resources :reviews, except: [:new]
  resources :categories, only: [:index]
  resource :profile, only: [:show, :edit, :update]
  resource :search

  # resources :reviews, only : [:new]
  # match "writeareview" => "reviews#new"
  # "writeareview/biz/:id"
  # match "profile" => "user#profile"
  # match "profile_bio" => "profile#profile_bio", via: :get
  # match "profile_bio" => "user#profile_bio", via: :put


  root to: "profiles#show"

end