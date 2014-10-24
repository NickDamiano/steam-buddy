class FindNewGames
  def self.run(games)
    in_db = Game.where(steam_appid: games)
    arr = []
    in_db.each do |game|
      arr.push(game.steam_appid)
    end
    return {
      success?: true,
      games: games - arr
    }
  end
end