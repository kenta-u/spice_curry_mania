Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[new create edit update destroy show] do
    get :favorites, on: :collection
  end
  resources :recipes, only: %i[new create index edit update destroy show] 
  resources :favorites, only: %i[create destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'recipes#index'
end
