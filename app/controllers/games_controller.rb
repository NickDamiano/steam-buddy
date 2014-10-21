require 'open-uri'
class GamesController < ApplicationController

  def get_users_games_data
    # binding.pry
    users_games_list = get_users_games_list(params[:id])
    # check if game id exists in database
    # if not, create api call and then save in database

    # build a list of games which need to call api
    api_list = build_api_call(users_games_list)
    get_and_save(api_list)
    redirect_to root_path
  end


  def get_and_save(api_list)
    binding.pry
    #builds 10 at a time
    until(api_list.empty?) do 
      # puts "Iteration #{counter}"
      set_of_games = api_list.pop(10)
      games_with_data = get_games(set_of_games)
      save_games(games_with_data)
    end
  end

  def get_games(set_of_games)
    puts "get_games"
    joined_set = set_of_games.join(',')
    # set_of_games.each_with_index do |piece, index|
      sleep 1
      url = "http://store.steampowered.com/api/appdetails/?appids=#{joined_set}"
      games = open(url).read
      json_games = JSON.parse(games)
      puts json_games.first
    return json_games
  end

  def save_games(games)
    puts "!!!!!!SAVE GAME!!!!!!!"
    games.each do |id, game_data|
      game = Game.new
      if games[id]["success"] == true
        game.name = game_data["data"]["name"]
        game.steam_appid = id
        game.about_the_game = game_data["data"]["about_the_game"]
        game.header_image = game_data["data"]["header_image"]
        game.pc_requirements = game_data["data"]["pc_requirements"]["minimum"]
        game.mac_requirements = game_data["data"]["mac_requirements"]["minimum"]
        game.linux_requirements = game_data["data"]["linux_requirements"]["minimum"]
        game.metacritic_score = game_data["data"]["metacritic_score"]["score"]
        if game_data["data"]["categories"].first["id"] == "1"
          game.multiplayer = true
        else
          game.multiplayer = false
        end
        game_data["data"]["genres"].each do |genre| 
          game.genres.create(:genre => genre["description"])
        end
        game_data["data"]["screenshots"].each do |screenshot|
          game.screenshots.create(:url => screenshot["path_thumbnail"])
        end
        game.release_date = game_data["data"]["release_date"]["date"]
      end
    end
  end
end