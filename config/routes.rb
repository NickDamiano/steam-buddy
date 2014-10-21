Rails.application.routes.draw do
  root to: 'home#index'
  post '/main', to: 'home#main'
  get '/games/:id', to: 'games#get_users_games_data'
end
