Rails.application.routes.draw do
  root "movies#index"
  devise_for :users
  resources :movies, only: [:index, :create, :show]
  resources :reviews, except: [:edit, :update]
  get "/static_pages/about" => "static_pages#about", as: "about"
  get "/users/activity" => "users#activity", as: "activity"
end
