Rails.application.routes.draw do
  resources :friendships, except: [:destroy]
  delete '/friendships', to: 'friendships#destroy'
  post '/send_request', to: 'friendships#request_create'

  resources :find_friends, only: [:new, :index, :create]

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    get 'login', to: 'friendships#index'
  end

  root 'friendships#index'
end
