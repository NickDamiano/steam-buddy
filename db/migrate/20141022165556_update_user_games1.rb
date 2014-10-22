class UpdateUserGames1 < ActiveRecord::Migration
  def change
    remove_column :usergames, :user_id, :integer
    remove_column :usergames, :game_id, :integer
  end
end
