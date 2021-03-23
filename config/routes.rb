Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #home
  root 'welcome#index'

  #users
  resources :users, only: [:new, :create]

  #login
  get '/login', to: 'sessions#new'
end
