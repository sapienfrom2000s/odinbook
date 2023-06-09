# frozen_string_literal: true

Rails.application.routes.draw do

  scope ':username' do
    resources :posts do
      resources :likes, only: %i[create destroy]
      resources :comments, except: %i[index destroy]
    end
    resources :message, only: %i[index new create]
  end

  resources :feeds, only: %[index]
  root 'feeds#index'

  resources :friendships, except: [:destroy]
  delete '/friendships', to: 'friendships#destroy'
  post '/send_request', to: 'friendships#request_create'
  get '/message/friends', to: 'friendships#list_friends'

  resources :find_friends, only: %i[new index create]
  delete '/find_friends', to: 'find_friends#destroy'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  devise_scope :user do
    get 'login', to: 'friendships#index'
  end
end
