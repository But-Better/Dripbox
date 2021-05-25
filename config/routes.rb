Rails.application.routes.draw do
  get '/agb', to:"site_informations#agb"
  get '/datenschutz', to:"site_informations#datenschutz"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
