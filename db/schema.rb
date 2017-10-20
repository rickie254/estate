# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171013042059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "galleries", force: :cascade do |t|
    t.integer "property_id"
    t.string "images", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string "type"
    t.string "title"
    t.integer "gallery_id"
    t.string "address"
    t.string "district"
    t.string "nearby"
    t.integer "value_cents", null: false
    t.string "value_currency", default: "BRL", null: false
    t.integer "deal"
    t.float "global_area"
    t.boolean "featured"
    t.integer "profile"
    t.integer "position"
    t.integer "number_of_rooms"
    t.float "private_area"
    t.integer "number_of_boxes"
    t.boolean "roof"
    t.integer "condominium_cents"
    t.string "condominium_currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
