Rails.application.routes.draw do
  resources :universes
  resources :catalogs
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :moons
  resources :entries
  root 'toolbox#landing'
  resources :users
  resources :moons
  get '/dashboard' => 'toolbox#dashboard'
  get '/user_index' => 'toolbox#user_index'
  get '/search' => 'toolbox#search'
  get '/regions' => 'toolbox#regions'
  get '/systems' => 'toolbox#systems'
  get '/user_catalog' => 'toolbox#user_catalog'
  get '/user_dashboard' => 'toolbox#user_dashboard'

  get '/flagged' => 'toolbox#flagged'
  get '/info' => 'toolbox#info'

  get '/' => 'toolbox#landing'



end
