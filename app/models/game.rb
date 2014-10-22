class Game < ActiveRecord::Base
  has_many :screenshots
  has_many :game_genres
  has_many :genres, through: :game_genres
  has_many :users, through: :usergames
  has_many :usergames
  has_many :friends, through: :friend_games
  has_many :friend_games
end