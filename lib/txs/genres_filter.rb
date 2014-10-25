class GenresFilter
  def self.run(pool, genres)
    selected_genres = []
    genres.each do |genre, val|
      if val == "1"
        selected_genres.push(genre)
      end
    end
    if selected_genres.empty?
      genres.each do |genre, val|
        selected_genres.push(genre)
      end
    end
    new_pool = []
    pool.each do |game|
      game.genres.each do |genre|
        if selected_genres.include? genre.genre
          new_pool.push(game)
        end
      end
    end
    return new_pool
  end
end