class Game < ActiveRecord::Base
  has_many :screenshots
  has_many :game_genres
  has_many :genres, through: :game_genres
end