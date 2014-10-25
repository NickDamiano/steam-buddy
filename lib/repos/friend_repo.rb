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
    #friends_array is array of numbers
    #////////////////////////////////
    #this shit right here is more or less working, but i need to get 
    #username/personaname from the json_players loop before writing it
    #to the db down on line 58 - commented out because the pop
    #was messing up the test/////////////////////////
    # until(friends_array.empty?) do 
    #   chunk = friends_array.pop(99)
    #   chunk = chunk.join(',')
    #   url = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=#{ENV['STEAM_KEY']}&steamids=#{chunk}"
    #   begin
    #     response = open(url).read
    #   rescue OpenURI::HTTPError
    #     return {
    #       success?: false,
    #       error: "Internal Server Error"
    #     }
    #   end
    #   json_players = JSON.parse(response)
    # end
      # steam_id_64 = ""
      # persona_name = ""
      # json_players["response"]["players"].each do |player|
      #   #player["fieldName"] is how you access each field
      #   #grab persona name
      #   #maybe personastate? i think that tells you which game they're in
      #   #mvp, i know i know. 
      # end
    friends_obj = []
    friends_array.each do |friend|
      persona_name = ""
      friends_obj.push(user.friends.create(:steam_id_64 => friend))
    end
    return {
      success?: true,
      friends: friends_obj
    }
  end

  def self.get_friends_games(friends)
    #only calls this if user selects friends in filter
    friends_games = {}
    friends.each do |friend|
      games_list = []
      url = "http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_KEY']}&steamid=#{friend.steam_id_64}&format=json"
      begin
        response = open(url).read
      rescue OpenURI::HTTPError
        return {
          success?: false,
          error: "Internal Server Error"
        }
      end
      #ADD CODE IN CASE THEY ARE PRIVATE IN WHICH CASE
      #THE ONLY THING THAT RETURNS IS A HASH WITH RESPONSE POINTING
      #TO AN EMPTY HASH
      games = JSON.parse(response)
      games["response"]["games"].each do |game|
        games_list.push(game["appid"])
      end
      friends_games[friend.steam_id_64] = games_list
    end
    return {
      success?: true, 
      friends_games: friends_games
      #returns data structure {1343434343 => [3434324,2342342]}
    }
  end

  def self.compare_friends_games(friends_games, user_games)
#     common = []
# (friend1 & friend2 & friend3).each {|i| common.push(i)}
    friends_games.each do |key, friend|
      user_games = user_games & friend
    end

    return {success?: true, games: user_games}
  end

end