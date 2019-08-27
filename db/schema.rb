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

ActiveRecord::Schema.define(version: 2019_08_27_004915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pokemon", force: :cascade do |t|
    t.string "name", null: false
    t.integer "height"
    t.integer "weight"
    t.string "sprite"
    t.string "shape"
    t.decimal "capture_rate", precision: 5, scale: 2, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pokemon_types", id: false, force: :cascade do |t|
    t.bigint "pokemon_id", null: false
    t.bigint "type_id", null: false
    t.index ["pokemon_id", "type_id"], name: "index_pokemon_types_on_pokemon_id_and_type_id", unique: true
  end

  create_table "types", force: :cascade do |t|
    t.string "name", null: false
  end

end
