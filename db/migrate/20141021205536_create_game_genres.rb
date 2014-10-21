class CreateGameGenres < ActiveRecord::Migration
  def change
    create_table :game_genres do |t|
      t.references :game, index: true
      t.references :genre, index: true

      t.timestamps
    end
  end
end
