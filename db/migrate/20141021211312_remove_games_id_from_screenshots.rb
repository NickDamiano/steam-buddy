class RemoveGamesIdFromScreenshots < ActiveRecord::Migration
  def change
    remove_column :screenshots, :games_id, :integer
  end
end
