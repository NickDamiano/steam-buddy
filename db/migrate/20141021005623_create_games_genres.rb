class CreateGamesGenres < ActiveRecord::Migration
  def change
    create_table :games_genres do |t|
      t.references :games
      t.references :genres
      
      t.timestamps
    end
  end
end
