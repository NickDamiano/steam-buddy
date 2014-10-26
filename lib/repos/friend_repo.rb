require 'open-uri' 
require 'JSON' 

class FriendRepo
  def self.get_friends(user)
    url = "http://api.steampowered.com/ISteamUser/GetFriendList/v0001/?key=#{ENV['STEAM_KEY']}&steamid=#{user}&relationship=friend"
    begin 
      response = open(url).read 
    rescue OpenURI::HTTPError
      return {
        success?: false,
        error: "Internal Server Error"
      }
    end
    users_friends = JSON.parse(response)
    friends_array = [] 

    users_friends["friendslist"]["friends"].each do |friend|
      friends_array.push(friend["steamid"])
    end
    return {
      success?: true,
      friends: friends_array
    }
  end

  def self.save_friends(user, friends_array)
    #user is a db object
    #friends_array is array of player_ids
    new_friend_data = {}
    #loop through each friend id until the array is empty - pop out 99, call the api, build up the players hash
    until(friends_array.empty?) do 
      chunk = friends_array.pop(99)
      chunk = chunk.join(',')
      url = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=#{ENV['STEAM_KEY']}&steamids=#{chunk}"
      begin
        response = open(url).read
      rescue OpenURI::HTTPError
        return {
          success?: false,
          error: "Internal Server Error"
        }
      end
      json_players = JSON.parse(response)
      json_players["response"]["players"].each do |player|
        new_friend_data[player["steamid"]] = {:id => player["steamid"], :name => player["personaname"] }
      end
      #after this loop we have current group of 99 in a hash like {4343939393 => {id: 4343939393, name: Blitzcat}, 34342343 => {id: 34342343, name: japutie}}
    end
    #after this loop we have all the friends from their friends list inside of new_friend_data in the same format as above
    friends_obj = []
    existing_friends_in_db = user.friends
    new_friend_data.each do |friend_id, friend_data|
      id = friend_id.to_i
      name = friend_data[:name]
      if Friend.find_by(:steam_id_64 => id) == nil
        friends_obj.push(user.friends.create(:steam_id_64 => id, :persona_name => name))        
      end
    end
    #after this loop we have friends_obj as an array of db objects
    return {
      success?: true,
      friends: friends_obj
    }
  end

  def self.get_friends_games(friends)
    #only calls this if user selects friends in filter
    #maybe make this so the friends are db objects
    friends_games = {}
    friends.each do |friend|
      games_list = []
      url = "http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_KEY']}&steamid=#{friend}&format=json"
      begin
        response = open(url).read
      rescue OpenURI::HTTPError
        return {
          success?: false,
          error: "Internal Server Error"
        }
      end
      games = JSON.parse(response)
      #check to see if user is private and empty hash is returned
      if games["response"] == {}
        #skip loop iteration
        #add to private array to return to tell user friend was private
        next
      end
      games["response"]["games"].each do |game|
        games_list.push(game["appid"])
      end
      friends_games[friend] = games_list
    end
    return {
      success?: true, 
      friends_games: friends_games
      #returns data structure [{1343434343 => [3434324,2342342]}]
      #go through the friends games and find common games
    }
  end

  def self.compare_friends_games(friends_games, user_games_objects)
#     user_games_objects = [dbObject, dbObject]
# => friends_games = {34343=>[343,343]}
    # user_games_objects.each do |game_obj|
    #   user_games.push(game_obj.steam_appid)
    # end
    binding.pry
    user_games = []
    common_games = friends_games.first[1]
    friends_games.each do |id, games|
      common_games =  common_games && games
    end
    user_games_objects.each do |game_obj|
      common_games.each do |game_id|
        if game_id == game_obj.steam_appid
          user_games.push(game_obj)
        end
      end
    end

    return {success?: true, games: user_games}
  end

end