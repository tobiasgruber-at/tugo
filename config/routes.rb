Rails.application.routes.draw do
  root "home#index"
  resources :keywords, only: [:create, :destroy]
  resources :people, only: [:index, :show, :update]
  resources :person_report, only: [:show]
  resources :courses, only: [:index, :show]
  resources :theses, only: [:index, :show]
  resources :projects, only: [:index, :show]
  resources :favorites, only: [:index, :create, :update, :destroy]
  resources :favorites_report, only: [:index]
  resources :users, only: [:create]
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
