class SaveGames
  def self.run(games, ids)
    games.each_with_index do |game_data, i|
      game = Game.new
      if game_data["success"] == true
        game.name = game_data["data"]["name"]
        game.steam_appid = ids[i]
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
            if cat["id"] == 1 || cat["id"] == 9 || cat["id"] == 24
              game.multiplayer = true
            end

            category_db = Category.find_by(category: cat["description"])
            if category_db.nil?
              category_db = Category.new
              category_db.category = cat["description"]
              category_db.save
            end
            game.categories << category_db
          end
        end
        game.release_date = game_data["data"]["release_date"]["date"]
        game.save
        if game_data["data"]["genres"]
          game_data["data"]["genres"].each do |genre|
            genre_db = Genre.find_by(genre: genre["description"])
            if genre_db.nil?
              genre_db = Genre.new
              genre_db.genre = genre["description"]
              genre_db.save
            end
            game.genres << genre_db
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