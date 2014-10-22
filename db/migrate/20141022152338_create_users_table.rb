class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :steam_id_64
      t.string :steam_id
      t.string :avatar_icon
      t.boolean :vac_banned
      t.string :custom_url
      t.datetime :member_since
      t.string :location
      t.string :real_name
      t.integer :primary_group_id
      t.string :primary_group_name
    end
  end
end
