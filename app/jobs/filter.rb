class Filter
  @queue = :filter

  def self.perform(params)
    user = User.includes(:games).includes(:friends).find_by(steam_id_64: params["id"].to_i)
    pool = MultiplayerFilter.run(user, params["filters"]["multiplayer"])[:pool]
    pool = PlayedFilter.run(user, pool, params["filters"]["played"])
    pool = MetacriticFilter.run(pool, params["metacritic"])[:pool]
    friends = FriendsFilter.run(params["friends"])
    if !friends[:friends_selected].nil?
      friends_games = FriendRepo.get_friends_games(friends[:friends_selected])
      pool = FriendRepo.compare_friends_games(friends_games[:friends_games], pool)[:games]
    end
    pool = GenresFilter.run(pool, params["genres"])
    pool = CategoriesFilter.run(pool, params["categories"])
    sleep 1
    Pusher.trigger("steam_buddy_#{user[:steam_id_64]}", 'filter', {
      id: user.steam_id_64.to_s,
      game_id: pool.empty? ? "" : pool.sample[:steam_appid].to_s
    })
  end
end
