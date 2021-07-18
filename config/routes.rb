# frozen_string_literal: true

Rails.application.routes.draw do

  get '/agb', to: 'site_informations#agb'
  get '/datenschutz', to: 'site_informations#datenschutz'
  get '/uber',        to: 'site_informations#about'
  get '/ueber',       to: 'site_informations#about'

  get 'registrations/index'
  get 'home_pages/index'
  get '/dashboard', to: 'dashboard#index'
  get '/dashboard/:id', to: 'dashboard#index'

  get 'user_resource/index', to: 'user_resources#index'
  get 'user_resource/:id/edit', to: 'user_resources#edit'

  root 'dashboard#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :user
  resources :user_resources
  resources :tags
end
