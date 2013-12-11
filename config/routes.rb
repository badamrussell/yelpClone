YelpClone::Application.routes.draw do
  resources :users
  resource :session
  match "profile" => "user#profile"
  root to: "users#new"
end