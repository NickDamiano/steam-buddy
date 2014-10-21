Rails.application.routes.draw do
  root to: 'home#index'
  post '/main', to: 'home#main'
end
