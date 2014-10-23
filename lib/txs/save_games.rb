class SaveGames
  def self.run(games, ids)
    games.each_with_index do |game_data, i|
      game = Game.new
      if game_data["success"] == true
        game.name = game_data["data"]["name"]
        game.steam_appid = game_data["data"]["steam_appid"]
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
        game.steam_appid = ids[i]
        game.save
      end
    end
  end
end