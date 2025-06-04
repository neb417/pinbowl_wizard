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

ActiveRecord::Schema[8.0].define(version: 2025_06_04_173515) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "machines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "round_id", null: false
    t.bigint "machine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_matches_on_machine_id"
    t.index ["round_id"], name: "index_matches_on_round_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_matches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "match_id", null: false
    t.integer "score"
    t.integer "result", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_player_matches_on_match_id"
    t.index ["user_id"], name: "index_player_matches_on_user_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_rounds_on_season_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_seasons_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_organization_id"
    t.string "email"
  end

  add_foreign_key "matches", "machines"
  add_foreign_key "matches", "rounds"
  add_foreign_key "player_matches", "matches"
  add_foreign_key "player_matches", "users"
  add_foreign_key "rounds", "seasons"
  add_foreign_key "seasons", "organizations"
end
