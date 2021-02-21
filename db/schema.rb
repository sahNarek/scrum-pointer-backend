# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_23_195611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "estimates", force: :cascade do |t|
    t.bigint "voter_id", null: false
    t.bigint "ticket_id", null: false
    t.decimal "point"
    t.boolean "final_estimate", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "voting_session_id", null: false
    t.index ["ticket_id"], name: "index_estimates_on_ticket_id"
    t.index ["voter_id"], name: "index_estimates_on_voter_id"
    t.index ["voting_session_id"], name: "index_estimates_on_voting_session_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.boolean "estimated", default: false
    t.bigint "voting_session_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["voting_session_id"], name: "index_tickets_on_voting_session_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "voters", force: :cascade do |t|
    t.string "name"
    t.bigint "voting_session_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["voting_session_id"], name: "index_voters_on_voting_session_id"
  end

  create_table "voting_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.integer "voting_duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active"
    t.index ["user_id"], name: "index_voting_sessions_on_user_id"
  end

  add_foreign_key "estimates", "tickets"
  add_foreign_key "estimates", "voters"
  add_foreign_key "estimates", "voting_sessions"
  add_foreign_key "tickets", "voting_sessions"
  add_foreign_key "voters", "voting_sessions"
  add_foreign_key "voting_sessions", "users"
end
