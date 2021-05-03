Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users
  resources :vamps

  post '/login', to: 'auth#create'
  post '/encode', to: 'noodles#encode', as: 'encode'

end
