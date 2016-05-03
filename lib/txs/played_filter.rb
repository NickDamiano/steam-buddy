class PlayedFilter
  def self.run(user, pool, played)
    new_pool = []
    if played == "1"
      pool.each do |game|
        playtime = Usergame.find_by(user_id: user.id, game_id: game.id).playtime
        new_pool.push(game) if playtime.nil?
      end
    else
      return pool
    end
    return new_pool
  end
end