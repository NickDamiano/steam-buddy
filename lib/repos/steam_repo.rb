require 'open-uri'
require 'json'
require 'active_support/core_ext/hash'

class SteamRepo
  def self.get_user_summary(url)
    if !url.include?("steamcommunity.")
      return {
        success?: false,
        error: "Invalid URL"
      }
    end
    begin
      if url[-5..-1] == "/home"
        url.slice!(-5..-1)
      end
      if url[0..6] != 'http://'
        url = "http://#{url}"
      end
      response = open("#{url}/?xml=1").read
    rescue URI::InvalidURIError
      return {
        success?: false,
        error: "Invalid Steam URL"
      }
    rescue
      return {
        success?: false,
        error: "Something went wrong"
      }
    end
    response_hash = Hash.from_xml(response.gsub("\n", ""))
    if response_hash["response"]
      return {
        success?: false, 
        error: response_hash["response"]["error"]
      }
    elsif response_hash["profile"]["privacyState"] == "public"
      return {
        success?: true, 
        profile: response_hash["profile"]
      }
    elsif response_hash["profile"]["privacyState"] != "public"
      return {
        success?: false,
        error: "The specified URL has a private profile."
      }
    end
  end

  def self.get_user_games(id)
    url = "http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=#{ENV['STEAM_KEY']}&steamid=#{id}&format=json"
    begin
      response = open(url).read
    rescue OpenURI::HTTPError
      return {
        success?: false, 
        error: "Internal Server Error"
      }
    end
    users_games = JSON.parse(response)
    games_array = []
    playtimes_array = []
    users_games["response"]["games"].each do |game|
      games_array.push(game["appid"])
      playtimes_array.push(game["playtime_forever"])
    end
    return {
      success?: true, 
      games: games_array,
      playtimes: playtimes_array
    }
  end

  def self.get_games_descriptions(list)
    steam_appids = []
    error_ids = []
    i = 0
    size = list.length
    until(list.empty?) do
      games = []
      appids = []
      max = list.length < 10 ? list.length : 10
      (0...max).each do |j|
        gameid = list.pop(1)
        gameid = gameid.join(',')
        url = "http://store.steampowered.com/api/appdetails/?appids=#{gameid}"
        begin
          response = open(url).read
        rescue OpenURI::HTTPError => e
          puts "Failed"
          error_ids.push(gameid)
          sleep 3
          next
        end
        sleep 0.8
        i = i + 1
        puts "getting number#{i} out of #{size} games"
        json_games = JSON.parse(response)
        json_games.each do |id, data|
          games.push(data)
          steam_appids.push(id)
          appids.push(id)
        end
      end
      SaveGames.run(games, appids)
    end

    until(error_ids.empty?) do
      games = []
      appids = []
      max = error_ids.length < 10 ? error_ids.length : 10

      (0...max).each do |j|
        gameid = error_ids.pop(1)
        gameid = gameid.join(',')
        url = "http://store.steampowered.com/api/appdetails/?appids=#{gameid}"
        begin
          response = open(url).read
        rescue OpenURI::HTTPError => e
          puts "Failed again"
          sleep 3
          next
        end
        sleep 0.8
        json_games = JSON.parse(response)
        json_games.each do |id, data|
          games.push(data)
          steam_appids.push(id)
          appids.push(id)
        end
      end

      SaveGames.run(games, appids)
    end

    return {
      success?: true,
      steam_appids: steam_appids
    }
  end
end
