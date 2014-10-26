require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def show
    @game = Game.find_by(steam_appid: params[:id])
    @user = User.find_by(steam_id_64: params[:user_id])
    @screenshots = @game.screenshots
    usergame = Usergame.find_by(game_id: @game.id, user_id: @user.id)
    if usergame.playtime.nil?
      @playtime = 0
    else
      @playtime = usergame.playtime
    end
  end

  def main
    @user_name = params[:user]
    user_hash = SteamRepo.get_user_summary(@user_name)
    if !user_hash[:success?]
      @error = user_hash[:error]
      @user_text = params[:user]
      render :index and return
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
    #friend_objects contains the database entries for all friends of user
    redirect_to "/games/#{save_result[:result].steam_id_64}"
  end
end
