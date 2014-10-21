class Genre < ActiveRecord::Base
  has_many :game_genres
  has_many :games, through: :game_genres
end
