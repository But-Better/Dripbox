# frozen_string_literal: true

Rails.application.routes.draw do
  get 'registrations/index', to: 'users#new', as: 'signup'
  get 'home_pages/index', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get '/dashboard', to: 'dashboard#index'
  get '/dashboard/:id', to: 'dashboard#index'

  get '/agb',         to: 'site_informations#agb'
  get '/datenschutz', to: 'site_informations#datenschutz'
  get '/uber',        to: 'site_informations#about'
  get '/ueber',       to: 'site_informations#about'

  root 'home_pages#index'

  resources :users
  resources :sessions, only: %i[new create destroy]
end
