class FindGenres 
  def self.run(user)
    binding.pry
    pool = []
    user.games.find_each do |game|
      game.genres.each do |genre|
        pool.push(genre.genre) if !pool.include?(genre.genre)
      end
    end
    return pool
  end
end