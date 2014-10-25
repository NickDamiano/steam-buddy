class FilterController < ApplicationController
  def index
    @id = params[:id]
  end

  def apply_filters
    multiplayer = params[:filters][:multiplayer]
    if multiplayer == "1"
      multiplayer = true
    else
      multiplayer = false
    end
    user = User.find_by(steam_id_64: params[:id])
    pool = user.games.where(multiplayer: multiplayer)
    game = pool.sample
    redirect_to "/result/#{game.steam_appid}"
  end
end