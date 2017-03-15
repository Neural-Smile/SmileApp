Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get 'signup' => 'users#new'
  post 'digest' => 'home#digest'
  resources :users
end
