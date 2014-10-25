class FilterController < ApplicationController
  def index
    user = User.find_by(steam_id_64: params[:id])
    @id = params[:id]
    @genres = FindGenres.run(user)
  end

  def apply_filters
    user = User.find_by(steam_id_64: params[:id])
    pool = MultiplayerFilter.run(user, params[:filters][:multiplayer])[:pool]
    pool = GenresFilter.run(pool, params[:genres])
    game = pool.sample
    redirect_to "/result/#{game.steam_appid}"
  end
end