class MultiplayerFilter
  def self.run(user, num)
    if num == "1"
      pool = user.games.where(multiplayer: true)
    else
      pool = user.games
    end
    return {
      success?: true,
      pool: pool
    }
  end
end