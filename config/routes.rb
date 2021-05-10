Rails.application.routes.draw do
  root 'start#index'
  get "/start", to: "start#index"
end

