class AddFriendIDandGameIDtoFriendGames < ActiveRecord::Migration
  def change
    change_table :friend_games do |t|
      t.belongs_to :friend
      t.belongs_to :game
    end
  end
end
