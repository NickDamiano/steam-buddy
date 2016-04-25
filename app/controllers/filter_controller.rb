class FilterController < ApplicationController
  def index
    id_int = params[:id].to_i
    user = User.find_by(steam_id_64: id_int)
    @id = id_int
    @genres = FindGenres.run(user)
    @friends = User.find_by(steam_id_64: id_int).friends
  end

  def apply_filters
   user = User.includes(:games).includes(:friends).find_by(steam_id_64: params[:id])
   pool = MultiplayerFilter.run(user, params[:filters][:multiplayer])[:pool]
   pool = PlayedFilter.run(user, pool, params[:filters][:played])
   pool = MetacriticFilter.run(pool, params[:metacritic])[:pool]
   friends = FriendsFilter.run(params[:friends])
   if !friends[:friends_selected].nil?
     friends_games = FriendRepo.get_friends_games(friends[:friends_selected])
     pool = FriendRepo.compare_friends_games(friends_games[:friends_games], pool)[:games]
   end
   pool = GenresFilter.run(pool, params[:genres])
   if pool.empty?
    flash[:alert] = "No games matched these filters"
    redirect_to :back
   else
    game = pool.sample
    redirect_to "/result/#{game.steam_appid}/#{user.steam_id_64}"
   end
 end
end