class FindNewGames
  def self.run(games)
    id_array = []
    games.each do |game|
      id_array.push(game.steam_appid)
    end
    in_db = Game.where(steam_appid: id_array)
    return {
      success?: true,
      games: games - in_db
    }
  end
end