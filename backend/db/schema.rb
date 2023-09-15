# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_14_204109) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "match_rosters", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "team_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_rosters_on_match_id"
    t.index ["player_id"], name: "index_match_rosters_on_player_id"
    t.index ["team_id"], name: "index_match_rosters_on_team_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "winner_team_id", null: false
    t.bigint "other_team_id", null: false
    t.bigint "play_area_id", null: false
    t.boolean "is_validated", default: false, null: false
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_matches_on_created_by_id"
    t.index ["other_team_id"], name: "index_matches_on_other_team_id"
    t.index ["play_area_id"], name: "index_matches_on_play_area_id"
    t.index ["winner_team_id"], name: "index_matches_on_winner_team_id"
  end

  create_table "play_areas", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.integer "num_courts"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "net_height"
    t.boolean "is_lined"
    t.boolean "is_public"
    t.boolean "has_rentals"
    t.boolean "has_restrooms"
    t.string "embedLink"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "avatar_picture"
    t.text "description"
    t.integer "elo_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roster_records", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "player_id", null: false
    t.datetime "joined_at"
    t.datetime "left_at"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_roster_records_on_player_id"
    t.index ["team_id"], name: "index_roster_records_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "captain_id"
    t.index ["captain_id"], name: "index_teams_on_captain_id"
  end

  add_foreign_key "match_rosters", "matches"
  add_foreign_key "match_rosters", "players"
  add_foreign_key "match_rosters", "teams"
  add_foreign_key "matches", "play_areas"
  add_foreign_key "matches", "players", column: "created_by_id"
  add_foreign_key "matches", "teams", column: "other_team_id"
  add_foreign_key "matches", "teams", column: "winner_team_id"
  add_foreign_key "roster_records", "players"
  add_foreign_key "roster_records", "teams"
  add_foreign_key "teams", "players", column: "captain_id"
end
