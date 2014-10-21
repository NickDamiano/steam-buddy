class Game < ActiveRecord::Base
  has_many :screenshots
  has_many :games_genres
  has_many :genres, through :games_genres
end