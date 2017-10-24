Rails.application.routes.draw do
  devise_for :users
  resources :moons
  resources :entries
  root 'toolbox#landing'
  resources :users
  resources :moons
  get '/dashboard' => 'toolbox#dashboard'
  get '/user_index' => 'toolbox#user_index'
  get '/catalog' => 'toolbox#catalog'
  get '/' => 'toolbox#landing'



end
