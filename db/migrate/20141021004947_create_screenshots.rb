class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.string :url
      t.references :games

      t.timestamps
    end
  end
end
