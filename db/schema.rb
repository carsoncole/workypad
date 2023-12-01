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

ActiveRecord::Schema[7.1].define(version: 2023_12_01_233631) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "response"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "entity"
    t.string "title"
    t.string "url"
    t.text "description"
    t.integer "status", default: 0
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "source_id"
    t.string "salary"
    t.string "primary_contact_name"
    t.string "primary_contact_email"
    t.string "primary_contact_phone"
    t.integer "mode"
    t.datetime "status_updated_at"
    t.boolean "is_agency", default: false
    t.date "applied_on"
    t.index ["user_id", "order"], name: "index_jobs_on_user_id_and_order"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_notes_on_job_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

  add_foreign_key "feedbacks", "users"
  add_foreign_key "notes", "jobs"
end
