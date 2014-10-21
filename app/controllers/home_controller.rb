require 'net/http'
require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def main
    @user_name = params[:user]
    # binding.pry
    # p "!!"
    @user_data = open("http://steamcommunity.com/id/" + @user_name+"/?xml=1").read
    user_parsed_data = Hash.from_xml(@user_data.gsub("\n", ""))
    @user_id = user_parsed_data["profile"]["steamID64"]
    # url = URI.parse('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' + ENV['STEAM_KEY'] + '&steamids=76561197960435530')
    # req = Net::HTTP::Get.new(url.to_s)
    # res = Net::HTTP.start(url.host, url.port {|http| http.request(req)})
    #get the user
    #parse

  end

end
