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

ActiveRecord::Schema.define(version: 20171030153212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_properties", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.integer "kind"
    t.integer "deal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extra_lists", force: :cascade do |t|
    t.integer "property_id"
    t.string "list", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.integer "position"
    t.integer "value_cents", null: false
    t.string "value_currency", default: "BRL", null: false
    t.integer "deal"
    t.boolean "is_featured"
    t.boolean "is_enterprise"
    t.float "global_area"
    t.integer "profile"
    t.integer "number_of_rooms"
    t.float "private_area"
    t.integer "number_of_boxes"
    t.boolean "roof"
    t.integer "condominium_cents"
    t.string "condominium_currency", default: "BRL", null: false
    t.integer "terrain_kind"
    t.integer "comercial_kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
