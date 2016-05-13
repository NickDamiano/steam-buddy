class CreateResult 
  def self.run(user_id, game_id)
  	result = Result.new
  	result.user_id = user_id
  	result.game_id = game_id
  	result.save
  end
end