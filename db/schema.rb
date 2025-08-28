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

ActiveRecord::Schema[7.1].define(version: 2025_08_26_022515) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "status"
    t.decimal "latitude"
    t.decimal "longitude"
    t.jsonb "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incident_events", force: :cascade do |t|
    t.bigint "incident_id", null: false
    t.string "kind"
    t.datetime "occurred_at"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incident_id"], name: "index_incident_events_on_incident_id"
  end

  create_table "incidents", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.string "status"
    t.string "severity"
    t.datetime "started_at"
    t.datetime "resolved_at"
    t.string "cause"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_id"], name: "index_incidents_on_asset_id"
    t.index ["severity"], name: "index_incidents_on_severity"
    t.index ["started_at"], name: "index_incidents_on_started_at"
    t.index ["status"], name: "index_incidents_on_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_orders", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.string "title"
    t.text "description"
    t.datetime "scheduled_for"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "priority", default: "normal", null: false
    t.string "assigned_to"
    t.index ["asset_id"], name: "index_work_orders_on_asset_id"
  end

  add_foreign_key "incident_events", "incidents"
  add_foreign_key "incidents", "assets"
  add_foreign_key "work_orders", "assets"
end
