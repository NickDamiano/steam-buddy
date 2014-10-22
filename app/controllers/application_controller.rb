class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_users_games_list(id)
    url = "http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_KEY']}&steamid=#{id}&format=json"
    users_games = open(url).read
    parsed_users_games = JSON.parse(users_games)
    games_array = []
    parsed_users_games["response"]["games"].each do |game|
      games_array.push(game["appid"])
    end
    return games_array
  end

  def build_api_call(users_games_list)
    users_games_in_db = Game.where(steam_appid: users_games_list)
    users_games_in_db_array = []
    users_games_in_db.each do |game|
      users_games_in_db_array.push(game.steam_appid)
    end
    api_list = users_games_list - users_games_in_db_array
    return api_list
  end
end
