Rails.application.routes.draw do
  resources :people, only: [:show, :index]
  resources :courses, only: [:show, :index]
  resources :theses, only: [:show, :index]
  resources :projects, only: [:show, :index]
end
