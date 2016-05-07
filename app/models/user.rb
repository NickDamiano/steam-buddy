class User < ActiveRecord::Base
  has_many :games, through: :usergames
  has_many :usergames
  has_many :friends
  has_many :results
end
