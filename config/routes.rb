Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[new create edit update destroy show] do
    get :favorites, on: :collection
  end
  resources :recipes, only: %i[new create index edit update destroy show] do
    resources :favorites, only: %i[create destroy]
  end
  
  namespace :reicpes do
    resources :searches, only: %i[index]
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'recipes#index'
end
