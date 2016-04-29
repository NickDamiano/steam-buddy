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
    SteamRepo.get_games_descriptions(missing)
  end

end
