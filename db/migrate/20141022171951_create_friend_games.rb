class CreateFriendGames < ActiveRecord::Migration
  def change
    create_table :friend_games do |t|

      t.timestamps
    end
  end
end
