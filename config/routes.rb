# frozen_string_literal: true

Rails.application.routes.draw do
  get 'registrations/index', to: 'users#new', as: 'signup'

  get '/logout', to: 'sessions#destroy'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'registrations/index', to: 'users#new'

  get '/dashboard', to: 'dashboard#index'
  get '/dashboard/:id', to: 'dashboard#index'

  get '/agb', to: 'site_informations#agb'
  get '/datenschutz', to: 'site_informations#datenschutz'
  get '/uber', to: 'site_informations#about'
  get '/ueber', to: 'site_informations#about'

  root 'home_pages#index'

  resources :users, only: %i[new create] do
    member do
      get :confirm_email
    end
  end
end
