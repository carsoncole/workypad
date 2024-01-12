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

ActiveRecord::Schema[7.1].define(version: 2024_01_12_201328) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "record_id"
    t.integer "old_record_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.integer "old_record_id"
    t.bigint "record_id"
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "response"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.integer "arrangement"
    t.string "entity_url"
    t.string "agency"
    t.integer "old_id"
    t.boolean "is_favorite"
    t.index ["agency"], name: "index_jobs_on_agency", opclass: :gin_trgm_ops, using: :gin
    t.index ["entity"], name: "index_jobs_on_entity", opclass: :gin_trgm_ops, using: :gin
    t.index ["primary_contact_name"], name: "index_jobs_on_primary_contact_name", opclass: :gin_trgm_ops, using: :gin
    t.index ["title"], name: "index_jobs_on_title", opclass: :gin_trgm_ops, using: :gin
    t.index ["user_id", "order"], name: "index_jobs_on_user_id_and_order"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category"
    t.integer "old_job_id"
    t.uuid "job_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.uuid "job_id"
    t.datetime "remind_at"
    t.integer "way", null: false
    t.boolean "is_dismissed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "days_to_auto_archive", default: 21, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_settings_on_user_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "feedbacks", "users"
end
