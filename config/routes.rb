# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'registrations/index'
  get 'home_pages/index'
  root 'home_pages#index'

  resource :users
end
