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

ActiveRecord::Schema.define(version: 20141102001350) do

  create_table "friend_games", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "friend_id"
    t.integer  "game_id"
  end

  create_table "friends", force: true do |t|
    t.integer  "steam_id_64",      limit: 8
    t.string   "persona_name"
    t.string   "profile_url"
    t.string   "avatar"
    t.integer  "primary_clan_id"
    t.datetime "time_created"
    t.string   "loc_country_code"
    t.integer  "user_id"
  end

  create_table "game_genres", force: true do |t|
    t.integer  "game_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_genres", ["game_id"], name: "index_game_genres_on_game_id", using: :btree
  add_index "game_genres", ["genre_id"], name: "index_game_genres_on_genre_id", using: :btree

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

  create_table "usergames", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "playtime"
  end

  create_table "users", force: true do |t|
    t.integer  "steam_id_64",        limit: 8
    t.string   "steam_id"
    t.string   "avatar_icon"
    t.boolean  "vac_banned"
    t.string   "custom_url"
    t.datetime "member_since"
    t.string   "location"
    t.string   "real_name"
    t.integer  "primary_group_id",   limit: 8
    t.string   "primary_group_name"
  end

end
