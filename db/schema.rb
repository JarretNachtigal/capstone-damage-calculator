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

ActiveRecord::Schema.define(version: 2021_12_03_192101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "damage_type"
    t.integer "base_ad"
    t.integer "base_ap"
    t.integer "base_ad_scaling"
    t.integer "base_ap_scaling"
    t.integer "ad_scaling"
    t.integer "ap_scaling"
    t.integer "ad_scaling_per_level"
    t.integer "ap_scaling_per_level"
    t.integer "champion_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "keywords"
  end

  create_table "calculations", force: :cascade do |t|
    t.integer "champion_id_one"
    t.integer "champion_id_two"
    t.integer "ability_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "output"
    t.integer "champ_one_level"
    t.integer "champ_two_level"
    t.integer "ability_level"
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
    t.float "mr_scaling"
    t.float "armor_scaling"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
