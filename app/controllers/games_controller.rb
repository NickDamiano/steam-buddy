require 'open-uri'
class GamesController < ApplicationController

  def get_users_games_data
    users_games_list = get_users_games_list(params[:id])
    # check if game id exists in database
    # if not, create api call and then save in database
    user = User.find_by(steam_id_64: params[:id])
    # build a list of games which need to call api
    api_list = build_api_call(users_games_list, user)
    get_and_save(api_list, user)
    get_new_games(users_games_list, user)
    # game = Game.first
    # render :partial => "home/filters", :locals => {game: game}
    render :json => user
  end


  def get_and_save(api_list, user)
    # binding.pry
    #builds 10 at a time
    until(api_list.empty?) do 
      # puts "Iteration #{counter}"
      set_of_games = api_list.pop(10)
      games_with_data = get_games(set_of_games)
      save_games(games_with_data, user)
    end
  end

  def get_games(set_of_games)
    joined_set = set_of_games.join(',')
    # set_of_games.each_with_index do |piece, index|
      sleep 1
      url = "http://store.steampowered.com/api/appdetails/?appids=#{joined_set}"
      games = open(url).read
      json_games = JSON.parse(games)
    return json_games
  end

  def save_games(games, user)
    games.each do |id, game_data|
      game = user.games.new
      if games[id]["success"] == true
        game.name = game_data["data"]["name"]
        game.steam_appid = id
        game.about_the_game = game_data["data"]["about_the_game"]
        game.header_image = game_data["data"]["header_image"]
        if !game_data["data"]["pc_requirements"].empty?
          game.pc_requirements = game_data["data"]["pc_requirements"]["minimum"]
        end
        if !game_data["data"]["mac_requirements"].empty?
          game.mac_requirements = game_data["data"]["mac_requirements"]["minimum"]
        end
        if !game_data["data"]["linux_requirements"].empty?
          game.linux_requirements = game_data["data"]["linux_requirements"]["minimum"]
        end
        if game_data["data"]["metacritic"]
          game.metacritic_score = game_data["data"]["metacritic"]["score"]
        end
        if game_data["data"]["categories"]
          game_data["data"]["categories"].each do |cat|
            if cat["id"] == "1" || cat["id"] == "9" || cat["id"] == "24"
              game.multiplayer = true
              break
            else
              game.multiplayer = false
            end
          end
        end
        game.release_date = game_data["data"]["release_date"]["date"]
        game.save
        if game_data["data"]["genres"]
          game_data["data"]["genres"].each do |genre| 
            game.genres.create(:genre => genre["description"])
          end
        end
        if game_data["data"]["screenshots"]
          game_data["data"]["screenshots"].each do |screenshot|
            game.screenshots.create(:url => screenshot["path_thumbnail"])
          end
        end
      else
        game.steam_appid = id
        game.save
      end
    end
  end
end