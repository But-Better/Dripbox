# frozen_string_literal: true

Rails.application.routes.draw do
  get 'registrations/index'
  get 'home_pages/index'
  root 'home_pages#index'
  get '/dashboard', to: 'dashboard#index'
  get '/dashboard/:id', to: 'dashboard#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :users
end
