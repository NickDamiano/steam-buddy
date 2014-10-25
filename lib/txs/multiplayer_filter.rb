class MultiplayerFilter
  def self.run(user, num)
    if num == "1"
      mp = true
    else
      mp = false
    end
    pool = user.games.where(multiplayer: mp)
    return {
      success?: true,
      pool: pool
    }
  end
end