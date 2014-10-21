class GamesGenres < ActiveRecord::Base
  belongs_to :games 
  belongs_to :genres
end
