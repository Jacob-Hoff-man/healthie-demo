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

ActiveRecord::Schema[8.0].define(version: 2024_03_30_000005) do
  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
  end

  create_table "journals", force: :cascade do |t|
    t.integer "client_id", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_journals_on_client_id"
  end

  create_table "plans", primary_key: "name", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provider_client_plans", force: :cascade do |t|
    t.integer "provider_id", null: false
    t.integer "client_id", null: false
    t.string "plan_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_provider_client_plans_on_client_id"
    t.index ["provider_id", "client_id"], name: "idx_provider_client_unique", unique: true
    t.index ["provider_id"], name: "index_provider_client_plans_on_provider_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_providers_on_email", unique: true
  end

  add_foreign_key "journals", "clients"
  add_foreign_key "provider_client_plans", "clients"
  add_foreign_key "provider_client_plans", "plans", column: "plan_name", primary_key: "name"
  add_foreign_key "provider_client_plans", "providers"
end
