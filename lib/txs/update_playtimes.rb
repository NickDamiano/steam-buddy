class UpdatePlaytimes
  def self.run(user, ids, playtimes)
    ids.each_with_index do |id, i|
      if playtimes[i] != 0
        game = Game.find_by(steam_appid: id)
        usergame = Usergame.find_by(game_id: game.id, user_id: user.id)
        usergame.playtime = playtimes[i]
        usergame.save
      end
    end
  end
end