Rails.application.routes.draw do

  get 'registrations/index'
  get 'home_pages/index'
  root 'home_pages#index'

end
