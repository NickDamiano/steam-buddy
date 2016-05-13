class ChangeIntegerToLongInteger < ActiveRecord::Migration
  def self.up
  	change_column :users, :steam_id_64, :integer, :limit => 8
  	change_column :users, :primary_group_id, :integer, :limit => 8
  	change_column :friends, :steam_id_64, :integer, :limit => 8
  end

  def self.down
  	change_column :users, :steam_id_64, :integer
  	change_column :users, :primary_group_id, :integer
  	change_column :friends, :steam_id_64, :integer
  end
end
