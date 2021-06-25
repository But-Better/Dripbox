# frozen_string_literal: true

Rails.application.routes.draw do

  get '/agb',         to: 'site_informations#agb'
  get '/datenschutz', to: 'site_informations#datenschutz'
  get '/uber',        to: 'site_informations#about'
  get '/ueber',       to: 'site_informations#about'
  get 'registrations/index'
  get 'home_pages/index'
  root 'home_pages#index'
  
  get '/dashboard', to: 'dashboard#index'
  get '/dashboard/:id', to: 'dashboard#index'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :users
end
