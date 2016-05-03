class CreateGameCategories < ActiveRecord::Migration
  def change
    create_table :game_categories do |t|
    	t.references :game, index: true
    	t.references :category, index: true

    	t.timestamps
    end
  end
end
