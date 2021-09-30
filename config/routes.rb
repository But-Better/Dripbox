# frozen_string_literal: true

Rails.application.routes.draw do
  resources :room_messages, only: [:create]
  resources :rooms, only: %i[index new create show]

  get '/logout', to: 'sessions#destroy'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/users', to: 'users#new'
  get 'registrations/index', to: 'users#new'

  get '/searchresults', to: 'search_results#index'

  get '/dashboard', to: 'dashboard#index'
  get '/dashboard/:id', to: 'dashboard#index'

  get '/agb', to: 'site_informations#agb'
  get '/datenschutz', to: 'site_informations#datenschutz'
  get '/uber', to: 'site_informations#about'
  get '/ueber', to: 'site_informations#about'

  root 'home_pages#index'

  get '/password_resets', to: 'password_resets#new'

  resources :password_resets

  resources :users, only: %i[new create edit update] do
    member do
      get :confirm_email
    end
  end

  post 'users/:id/edit' => 'users#update'

  resources :user_resources
  resources :tags
  resources :search, only: :index

  resources :contacts, only: %i[index new create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
