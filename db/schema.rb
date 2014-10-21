# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141021211506) do

  create_table "game_genres", force: true do |t|
    t.integer  "game_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_genres", ["game_id"], name: "index_game_genres_on_game_id"
  add_index "game_genres", ["genre_id"], name: "index_game_genres_on_genre_id"

  create_table "games", force: true do |t|
    t.string   "name"
    t.integer  "steam_appid"
    t.text     "about_the_game"
    t.string   "header_image"
    t.text     "pc_requirements"
    t.text     "mac_requirements"
    t.text     "linux_requirements"
    t.integer  "metacritic_score"
    t.boolean  "multiplayer"
    t.string   "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games_genres", force: true do |t|
    t.integer  "games_id"
    t.integer  "genres_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.string   "genre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "screenshots", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
  end

end
