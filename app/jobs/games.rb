class Games
  @queue = :games

  def self.perform(user_name)
    user_hash = SteamRepo.get_user_summary(user_name)
    if !user_hash[:success?]
      Pusher.trigger("steam_buddy_#{user_hash[:profile]['steamID64']}", 'error', {
        message: user_hash[:error]
      })
    end
    db_check = SaveUser.checkDb(user_hash[:profile]["steamID64"])
    user_to_save = ""
    if db_check[:success?]
      user_to_save = db_check[:result]
    else
      user_to_save = User.new
    end
    save_result = SaveUser.save(user_to_save, user_hash)
    #get friends list
    friends_hash = FriendRepo.get_friends(user_hash[:profile]["steamID64"])
    #save friends into repo
    user = save_result[:result]
    friends = friends_hash[:friends]
    friends_objects = FriendRepo.save_friends(user, friends)
    user2 = User.find_by(steam_id_64: save_result[:result].steam_id_64)
    games_response = SteamRepo.get_user_games(user2.steam_id_64)
    if !games_response[:success?]
      # display some error
    end
    new_games = FindNewGames.run(games_response[:games])
    descriptions_response = SteamRepo.get_games_descriptions(new_games[:games])
    if !descriptions_response[:success?]
      # error
    end
    #SaveGames.run(descriptions_response[:games], descriptions_response[:steam_appids])
    to_be_assigned = GetGamesNotAssigned.run(user2, games_response[:games])
    AssignGamesToUser.run(to_be_assigned[:games], user2)
    UpdatePlaytimes.run(user2, games_response[:games], games_response[:playtimes])
    Pusher.trigger("steam_buddy_#{user_hash[:profile]['steamID64']}", 'games', {
      id: user2.steam_id_64.to_s
    })
  end
end