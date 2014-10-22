class FriendGame < ActiveRecord::Base
  belongs_to :friend 
  belongs_to :game
end
