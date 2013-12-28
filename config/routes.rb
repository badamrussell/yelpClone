YelpClone::Application.routes.draw do


  #resources :business_photos, controller:"photo_details" , as: "business_photos"


  resources :users do
    get "add_photo" => "photos#new"
    get "photos" => "photos#user_show"
    get "new_list" => "lists#new"
    get "lists" => "lists#index"
    get "home" => "users#home"

    member do
      get "compliments" => "review_compliments#show"
      get "bookmarks" => "bookmarks#show"
    end
  end

  resources :bookmarks, only: [:create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  resources :businesses do
    match "writeareview" => "reviews#new"
    get "add_photo" => "photos#new"
    get "photos" => "photos#biz_show"
  end

  resources :photos, only: [:create] do
    get "details" => "photo_details#edit"
    put "details" => "photo_details#update"
    post "details" => "photo_details#create"
  end

  resources :categories, only: [:show, :index]
  resources :review_compliments, except: [:index, :new]

  resources :reviews, except: [:new] do
    get "compliment" => "review_compliments#new"

    member do
      post "toggle_vote"
    end
  end


  resources :lists, except: [:new, :show]
  resources :tips, except: [:new, :show]

  resources :review_votes, only: [:create, :destroy]
  resources :categories, only: [:index]
  resource :profile, only: [:show, :edit, :update]
  resource :search, only: [:show]


  # resources :reviews, only : [:new]
  # match "writeareview" => "reviews#new"
  # "writeareview/biz/:id"
  # match "profile" => "user#profile"
  # match "profile_bio" => "profile#profile_bio", via: :get
  # match "profile_bio" => "user#profile_bio", via: :put


  root to: "users#home"

end