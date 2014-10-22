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
    modify_user(user_parsed_data)
    # url = URI.parse('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' + ENV['STEAM_KEY'] + '&steamids=76561197960435530')
    # req = Net::HTTP::Get.new(url.to_s)
    # res = Net::HTTP.start(url.host, url.port {|http| http.request(req)})
    #get the user
    #parse
    redirect_to "/games/#{@user_id}"
  end

  def modify_user(user_parsed_data)
    puts "modifying user"
    user = User.find_by(steam_id_64: @user_id)
    if user.nil?
      user = User.new
      puts "creating a new user"
    else
      puts "user exists- updating"
    end
    #user = User.find_by(steam_id_64: @user_id)
    user.steam_id_64 = user_parsed_data["profile"]["steamID64"]
    unparsed_id = user_parsed_data["profile"]["steamID"]
    user.steam_id = unparsed_id.scan(/[A-Za-z]+\s[A-Za-z]*/).join
    user.avatar_icon = user_parsed_data["profile"]["avatarIcon"]
    if user_parsed_data["profile"]["vacBanned"].to_i > 0
      user.vac_banned = true
    else
      user.vac_banned = false
    end
    custom_url = user_parsed_data["profile"]["customURL"]
    user.custom_url = custom_url.scan(/[A-Za-z]+\s[A-Za-z]*/).join
    user.member_since = user_parsed_data["profile"]["memberSince"]
    location = user_parsed_data["profile"]["location"]
    user.location = location.scan(/[A-Za-z]+\s[A-Za-z]*/).join
    realname = user_parsed_data["profile"]["realname"]
    user.real_name = realname.scan(/[A-Za-z]+\s[A-Za-z]*/).join
    user.primary_group_id = user_parsed_data["profile"]["groups"]['group'].first["groupID64"]
    user.primary_group_name = user_parsed_data["profile"]["groups"]['group'].first["groupName"]
    user.save
  end


end
