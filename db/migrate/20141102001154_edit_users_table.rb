class EditUsersTable < ActiveRecord::Migration
  def change
  	change_column :users, :primary_group_id, :integer, :limit => 8
  	change_column :users, :steam_id_64, :integer, :limit => 8
  end
end
