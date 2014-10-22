class AddFriendsTable < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :steam_id_64
      t.string :persona_name
      t.string :profile_url
      t.string :avatar
      t.integer :primary_clan_id
      t.timestamp :time_created
      t.string :loc_country_code
    end
  end
end
