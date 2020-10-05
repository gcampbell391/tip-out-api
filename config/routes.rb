Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users

  #Authentication routes
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'

  #User Add Shift
  post '/add_shift', to: 'users#add_shift'

  #User Delete Shift
  post '/delete_shift', to: 'users#delete_shift'

end

