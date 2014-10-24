Rails.application.routes.draw do
  root to: 'home#index'
  post '/main', to: 'home#main'
  get '/games/:id', to: 'games#get_users_games_data'
  get '/users/:name', to: 'user#index'
  get '/filters/:id', to: 'filter#index'
end
