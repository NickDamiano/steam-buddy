class DropGamesGenresTable < ActiveRecord::Migration
  def change
  	drop_table :games_genres
  end
end
