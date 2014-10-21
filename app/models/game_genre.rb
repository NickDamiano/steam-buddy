class GameGenre < ActiveRecord::Base
  belongs_to :game
  belongs_to :genre
end
