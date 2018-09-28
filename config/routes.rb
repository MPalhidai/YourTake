Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users
  resources :movies, :only => [:index, :show]
  resources :reviews, :only => [:index, :show]

end
