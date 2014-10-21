class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :steam_appid
      t.text :about_the_game
      t.string :header_image
      t.text :pc_requirements
      t.text :mac_requirements
      t.text :linux_requirements
      t.integer :metacritic_score
      t.boolean :multiplayer
      t.string :release_date  

      t.timestamps
    end
  end
end
