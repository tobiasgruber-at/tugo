Rails.application.routes.draw do
  get 'people/show/:id' => 'people#show'
  get 'people/search/:term' => 'people#index'
end
