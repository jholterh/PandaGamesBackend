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

ActiveRecord::Schema[8.1].define(version: 2026_03_15_132308) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "leaderboard_entries", force: :cascade do |t|
    t.datetime "achieved_at", null: false
    t.datetime "created_at", null: false
    t.jsonb "metadata", default: {}
    t.bigint "mini_app_id", null: false
    t.integer "score", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["mini_app_id", "score"], name: "index_leaderboard_entries_on_mini_app_id_and_score", order: { score: :desc }
    t.index ["mini_app_id"], name: "index_leaderboard_entries_on_mini_app_id"
    t.index ["user_id"], name: "index_leaderboard_entries_on_user_id"
  end

  create_table "mini_apps", force: :cascade do |t|
    t.string "author"
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "is_published", default: false
    t.string "name", null: false
    t.integer "play_count", default: 0
    t.string "route_prefix"
    t.string "slug", null: false
    t.text "tags", default: [], array: true
    t.string "thumbnail_url"
    t.datetime "updated_at", null: false
    t.string "version"
    t.index ["slug"], name: "index_mini_apps_on_slug", unique: true
  end

  create_table "user_app_data", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "data", default: {}
    t.integer "high_score", default: 0
    t.datetime "last_played_at"
    t.bigint "mini_app_id", null: false
    t.integer "play_count", default: 0
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["mini_app_id"], name: "index_user_app_data_on_mini_app_id"
    t.index ["user_id", "mini_app_id"], name: "index_user_app_data_on_user_id_and_mini_app_id", unique: true
    t.index ["user_id"], name: "index_user_app_data_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "total_score", default: 0
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "leaderboard_entries", "mini_apps"
  add_foreign_key "leaderboard_entries", "users"
  add_foreign_key "user_app_data", "mini_apps"
  add_foreign_key "user_app_data", "users"
end
