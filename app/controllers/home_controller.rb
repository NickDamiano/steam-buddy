require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def show
    @game = Game.find_by(steam_appid: params[:id])
    @description = ActionView::Base.full_sanitizer.sanitize(@game.about_the_game)
    @user = User.find_by(steam_id_64: params[:user_id])
    @screenshots = @game.screenshots
    usergame = Usergame.find_by(game_id: @game.id, user_id: @user.id)
    if usergame.playtime.nil?
      @playtime = 0
    else
      @playtime = usergame.playtime
    end
  end

  def loading
    user_name = params[:user]
    user_hash = SteamRepo.get_user_summary(user_name)
    if !user_hash[:success?]
      Pusher.trigger("steam_buddy_#{user_hash[:profile]["steamID64"]}", 'error', {
        message: user_hash[:error]
      })
    end
    Resque.enqueue(Games, user_name)
    @user_id = user_hash[:profile]["steamID64"]
  end
end
