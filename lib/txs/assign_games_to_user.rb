class AssignGamesToUser
  def self.run(games, user)
    games = Game.where(steam_appid: games)
    games.each do |game|
      Usergame.create(user_id: user.id, game_id: game.id)
    end
    return {
      success?: true
    }
  end
end