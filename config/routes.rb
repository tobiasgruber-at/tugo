Rails.application.routes.draw do
  resources :people, only: [:index, :show]
  resources :courses, only: [:index, :show]
  resources :theses, only: [:index, :show]
  resources :projects, only: [:index, :show]
  resources :users, only: [:create]
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
