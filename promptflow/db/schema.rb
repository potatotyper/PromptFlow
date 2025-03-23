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

ActiveRecord::Schema[7.1].define(version: 2025_03_22_233120) do
  create_table "bad_feedbacks", force: :cascade do |t|
    t.integer "prompt_session_id", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prompt_session_id"], name: "index_bad_feedbacks_on_prompt_session_id"
  end

  create_table "good_feedbacks", force: :cascade do |t|
    t.integer "prompt_session_id", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prompt_session_id"], name: "index_good_feedbacks_on_prompt_session_id"
  end

  create_table "prompt_sessions", force: :cascade do |t|
    t.integer "uid"
    t.string "system_prompt"
    t.integer "like_count"
    t.integer "dislike_count"
    t.string "feedback"
    t.integer "prompt_sim"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_prompt_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "session_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bad_feedbacks", "prompt_sessions"
  add_foreign_key "good_feedbacks", "prompt_sessions"
  add_foreign_key "prompt_sessions", "users"
end
