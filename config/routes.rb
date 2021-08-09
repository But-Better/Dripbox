# frozen_string_literal: true

Rails.application.routes.draw do
  get '/logout', to: 'sessions#destroy'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'users', to: 'users#new'
  get 'registrations/index', to: 'users#new'

  get '/searchresults', to: 'search_results#index'

  get '/dashboard', to: 'dashboard#index'
  get '/dashboard/:id', to: 'dashboard#index'

  get 'user_resource/index', to: 'user_resources#index'
  get 'user_resource/:id/edit', to: 'user_resources#edit'

  get '/agb', to: 'site_informations#agb'
  get '/datenschutz', to: 'site_informations#datenschutz'
  get '/uber', to: 'site_informations#about'
  get '/ueber', to: 'site_informations#about'

  root 'home_pages#index'

  resources :password_resets

  resources :users, only: %i[new create] do
    member do
      get :confirm_email
    end
  end

  resources :user_resources
  resources :tags
  resources :search, only: :index

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
