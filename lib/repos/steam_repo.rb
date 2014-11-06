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
    games = []
    steam_appids = []
    until(list.empty?) do
      chunk = list.pop(1)
      chunk = chunk.join(',')
      url = "http://store.steampowered.com/api/appdetails/?appids=#{chunk}"
      begin
        response = open(url).read
      rescue OpenURI::HTTPError
        return {
          success?: false,
          error: "Internal Server Error"
        }
      end
      json_games = JSON.parse(response)
      json_games.each do |id, data|
        games.push(data)
        steam_appids.push(id)
      end
    end
    return {
      success?: true,
      games: games,
      steam_appids: steam_appids
    }
  end
end
