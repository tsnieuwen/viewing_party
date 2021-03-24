Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #home
  root 'welcome#index'

  #users
  resources :users, only: [:new, :create]

  #dashboard
  get '/dashboard', to: 'dashboard#index'
  
  #profile
  get '/profile', to: 'users#show'

  #login
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'

  #logout
  get '/logout', to: 'sessions#logout'
  delete '/logout', to: 'sessions#logout'

end
