class AddGameIdToScreenshots < ActiveRecord::Migration
  def change
    change_table :screenshots do |t|
      t.references :game
    end
  end
end
