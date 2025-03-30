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

ActiveRecord::Schema[8.0].define(version: 2024_03_30_000004) do
  create_table "animal_likes_foods", force: :cascade do |t|
    t.string "animal_name", null: false
    t.string "food_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_name", "food_name"], name: "index_animal_likes_foods_on_animal_name_and_food_name", unique: true
  end

  create_table "animals", primary_key: "name", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "noise", null: false
  end

  create_table "foods", primary_key: "name", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "animal_likes_foods", "animals", column: "animal_name", primary_key: "name"
  add_foreign_key "animal_likes_foods", "foods", column: "food_name", primary_key: "name"
end
