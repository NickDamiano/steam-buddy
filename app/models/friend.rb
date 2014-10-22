class Friend < ActiveRecord::Base
  belongs_to  :user
  has_many    :games, through: :friend_games
  has_many    :friend_games
end
