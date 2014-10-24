class AddPlaytimeToUsergame < ActiveRecord::Migration
  def change
    change_table :usergames do |t|
      t.integer :playtime
    end
  end
end
