class CategoriesFilter
  def self.run(pool, categories)
    selected_categories = []
    categories.each do |cat, val|
      if val == "1"
        selected_categories.push(cat)
      end
    end
    if selected_categories.empty?
      return pool
    end
    new_pool = []
    pool.each do |game|
      game.categories.each do |cat|
        if ((selected_categories.include? cat.category) && (!new_pool.include? game))
          new_pool.push(game)
        end
      end
    end
    return new_pool
  end
end