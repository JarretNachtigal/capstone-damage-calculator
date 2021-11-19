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

ActiveRecord::Schema.define(version: 2021_11_19_200054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "damage_type"
    t.integer "base_ad"
    t.integer "base_ap"
    t.float "ad_scaling"
    t.float "ap_scaling"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "champions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "base_hp"
    t.integer "base_ad"
    t.integer "base_ap"
    t.integer "base_mr"
    t.integer "base_armor"
    t.integer "hp_scaling"
    t.float "ad_scaling"
    t.float "ap_scaling"
    t.float "mr_scaling"
    t.float "armor_scaling"
    t.integer "champion_abilities_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
