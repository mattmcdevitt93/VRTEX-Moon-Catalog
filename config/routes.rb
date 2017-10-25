Rails.application.routes.draw do
  resources :catalogs
  devise_for :users
  resources :moons
  resources :entries
  root 'toolbox#landing'
  resources :users
  resources :moons
  get '/dashboard' => 'toolbox#dashboard'
  get '/user_index' => 'toolbox#user_index'
  get '/search' => 'toolbox#search'
  get '/' => 'toolbox#landing'



end
