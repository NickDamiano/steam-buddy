class FilterController < ApplicationController
  def index
    @id = params[:id]
  end

  def apply_filters
    user = User.find_by(steam_id_64: params[:id])
    pool = MultiplayerFilter.run(user, params[:filters][:multiplayer])[:pool]
    game = pool.sample
    redirect_to "/result/#{game.steam_appid}"
  end
end