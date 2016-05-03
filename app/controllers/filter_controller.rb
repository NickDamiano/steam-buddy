class FilterController < ApplicationController
  def index
    id_int = params[:id].to_i
    user = User.find_by(steam_id_64: id_int)
    @id = id_int
    @genres = FindGenres.run(user)
    @friends = User.find_by(steam_id_64: id_int).friends
  end

  def apply_filters
   @user_id = params[:id]
   Resque.enqueue(Filter, params)
   @loading_text = 'Selecting a game'
   render :template => "home/loading"
 end
end