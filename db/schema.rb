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

ActiveRecord::Schema[8.1].define(version: 2026_07_18_045103) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "care_record_reads", force: :cascade do |t|
    t.bigint "care_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "read_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["care_record_id", "user_id"], name: "index_care_record_reads_on_care_record_id_and_user_id", unique: true
    t.index ["care_record_id"], name: "index_care_record_reads_on_care_record_id"
    t.index ["user_id"], name: "index_care_record_reads_on_user_id"
  end

  create_table "care_records", force: :cascade do |t|
    t.integer "appetite", null: false
    t.bigint "care_user_id", null: false
    t.datetime "created_at", null: false
    t.integer "health_status", null: false
    t.string "memo"
    t.integer "sleep_quality", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["care_user_id"], name: "index_care_records_on_care_user_id"
    t.index ["user_id"], name: "index_care_records_on_user_id"
  end

  create_table "care_users", force: :cascade do |t|
    t.date "birthday", null: false
    t.integer "blood_type", null: false
    t.datetime "created_at", null: false
    t.bigint "family_id", null: false
    t.string "invite_code", null: false
    t.string "medical_condition_1"
    t.string "medical_condition_2"
    t.string "medical_condition_3"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_care_users_on_family_id"
    t.index ["invite_code"], name: "index_care_users_on_invite_code", unique: true
  end

  create_table "families", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "family_name"
    t.datetime "updated_at", null: false
  end

  create_table "family_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "family_id", null: false
    t.integer "role", default: 1, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["family_id"], name: "index_family_members_on_family_id"
    t.index ["user_id"], name: "index_family_members_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.string "tel_number", default: "", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tel_number"], name: "index_users_on_tel_number", unique: true
  end

  add_foreign_key "care_record_reads", "care_records"
  add_foreign_key "care_record_reads", "users"
  add_foreign_key "care_records", "care_users"
  add_foreign_key "care_records", "users"
  add_foreign_key "care_users", "families"
  add_foreign_key "family_members", "families"
  add_foreign_key "family_members", "users"
end
