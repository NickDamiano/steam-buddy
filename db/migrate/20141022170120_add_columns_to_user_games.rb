class AddColumnsToUserGames < ActiveRecord::Migration
  def change
    change_table :usergames do |t|
      t.belongs_to :user
      t.belongs_to :game
    end
  end
end
