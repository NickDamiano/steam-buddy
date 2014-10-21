class Genre < ActiveRecord::Base
  has_many :games_genres
  has_many :games, through: :games_genres
end
