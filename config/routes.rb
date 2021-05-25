Rails.application.routes.draw do

  get 'registrations', to: "registrations#index"
  get 'registrations/index'
  get "r", to: "registrations#index"

  get 'home_pages/index'
  get "login", to: "home_pages#index"
  get "signin", to: "home_pages#index"
  get "sign-in", to: "home_pages#index"
  root 'home_pages#index'

end
