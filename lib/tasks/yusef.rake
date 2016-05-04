require 'json'

namespace :yusef do
  desc "TODO"
  task get_missing_games: :environment do
    `wget 'http://api.steampowered.com/ISteamApps/GetAppList/v0002/' -O ./games/games.json`
    parsed = JSON.parse(File.read('./games/games.json'))
    games = []
    for game in parsed["applist"]["apps"]
      games.push game["appid"]
    end
    puts "found total of #{games.length} games"
    missing = FindNewGames.run(games)
    puts "#{missing[:games].length} games are missing from the db"
    # save missing games 
    SteamRepo.get_games_descriptions(missing[:games])
  end

  task fix_categories: :environment do
    `wget 'http://api.steampowered.com/ISteamApps/GetAppList/v0002/' -O ./games/games.json`
    parsed = JSON.parse(File.read('./games/games.json'))
    games = []
    for game in parsed["applist"]["apps"]
      url = "http://store.steampowered.com/api/appdetails/?appids=#{game['appid']}"
      begin
        response = open(url).read
      rescue OpenURI::HTTPError => e
        puts "Failed"
        sleep 3
        next
      end
      sleep 1.4
      json_games = JSON.parse(response)
      json_games.each do |id, data|
        if data["success"]
          db_game = Game.includes(:categories).find_by(steam_appid: game["appid"])
          if !db_game.nil?
            puts "game found #{id}"
            if db_game.categories.empty?
              data["data"]["categories"].each do |id2, cat|
                category_db = Category.find_by(category: cat["description"])
                if category_db.nil?
                  puts "category not found #{cat['description']}"
                  category_db = Category.new
                  category_db.category = cat["description"]
                  category_db.save
                end
                db_game.categories << category_db unless game.categories.any? {|c| c.category == cat["description"]}
              end
            end
            db_game.save
          end
        end
      end
    end
  end

end
