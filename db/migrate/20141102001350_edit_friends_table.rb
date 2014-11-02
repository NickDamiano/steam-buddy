class EditFriendsTable < ActiveRecord::Migration
  def change
  	  	change_column :friends, :steam_id_64, :integer, :limit => 8
  end
end
