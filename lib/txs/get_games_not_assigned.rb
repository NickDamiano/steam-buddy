class GetGamesNotAssigned
  def self.run(user, list)
    in_db_assigned = user.games
    games = []
    in_db_assigned.each do |game|
      games.push(game.steam_appid)
    end
    to_be_assigned = list - games
    return {
      success?: true,
      games: to_be_assigned
    }
  end
end