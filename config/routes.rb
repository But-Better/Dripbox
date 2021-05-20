Rails.application.routes.draw do

  get 'sven/index'
  get 'sven/help'
  get 'sven/intern'
  get 'registrations/index'
  get 'home_pages/index'
  root 'home_pages#index'

end
