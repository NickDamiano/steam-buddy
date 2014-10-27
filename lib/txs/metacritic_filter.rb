class MetacriticFilter
  def self.run(pool, score)
    score = score.to_i
    #takes pool of db objects, metacritic score as string
    if score == ""
      return pool 
    else
      new_pool = []
      pool.each do |game|
        if !game.metacritic_score.nil?
          if game.metacritic_score > score
            new_pool.push(game)
          end
        end
      end
    end
    return {
      success?: true,
      pool: new_pool
    }
  end
end