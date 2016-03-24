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

  def main
    @user_name = params[:user]
    Resque.enqueue(Games, @user_name)
    #friend_objects contains the database entries for all friends of user
    #redirect_to "/games/#{save_result[:result].steam_id_64}"
    # return 200
  end
end
