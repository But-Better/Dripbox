Rails.application.routes.draw do

  get '/dashboard', to: 'dashboard#index'
  get '/dashboard/:id', to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
