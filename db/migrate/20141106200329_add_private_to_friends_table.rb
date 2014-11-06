class AddPrivateToFriendsTable < ActiveRecord::Migration
  def change
  	add_column :friends, :private, :boolean
  end
end
