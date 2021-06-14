# frozen_string_literal: true

Rails.application.routes.draw do
  get 'registrations/index', to: 'users#new', as: 'signup'
  get 'home_pages/index', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  root 'home_pages#index'

  resources :users
  resources :sessions, only: %i[new create destroy]
end
