Rails.application.routes.draw do
  root to: 'home#index'
  post '/loading', to: 'home#loading'
  get '/games/:id', to: 'games#get_users_games_data'
  get '/users/:name', to: 'user#index'
  get '/filters/:id', to: 'filter#index'
  post '/filters/:id', to: 'filter#apply_filters'
  get '/result/:id/:user_id', to: 'home#show'
end
