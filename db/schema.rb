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

ActiveRecord::Schema[8.1].define(version: 2026_11_16_133737) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "inventories", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "image_url"
    t.bigint "creator_id", null: false
    t.bigint "category_id"
    t.jsonb "field_order", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "custom_string1_state", default: false, null: false
    t.string "custom_string1_name"
    t.string "custom_string1_description"
    t.boolean "custom_string1_show", default: false, null: false
    t.boolean "custom_string2_state", default: false, null: false
    t.string "custom_string2_name"
    t.string "custom_string2_description"
    t.boolean "custom_string2_show", default: false, null: false
    t.boolean "custom_string3_state", default: false, null: false
    t.string "custom_string3_name"
    t.string "custom_string3_description"
    t.boolean "custom_string3_show", default: false, null: false
    t.boolean "custom_text1_state", default: false, null: false
    t.string "custom_text1_name"
    t.string "custom_text1_description"
    t.boolean "custom_text1_show", default: false, null: false
    t.boolean "custom_text2_state", default: false, null: false
    t.string "custom_text2_name"
    t.string "custom_text2_description"
    t.boolean "custom_text2_show", default: false, null: false
    t.boolean "custom_text3_state", default: false, null: false
    t.string "custom_text3_name"
    t.string "custom_text3_description"
    t.boolean "custom_text3_show", default: false, null: false
    t.boolean "custom_int1_state", default: false, null: false
    t.string "custom_int1_name"
    t.string "custom_int1_description"
    t.boolean "custom_int1_show", default: false, null: false
    t.boolean "custom_int2_state", default: false, null: false
    t.string "custom_int2_name"
    t.string "custom_int2_description"
    t.boolean "custom_int2_show", default: false, null: false
    t.boolean "custom_int3_state", default: false, null: false
    t.string "custom_int3_name"
    t.string "custom_int3_description"
    t.boolean "custom_int3_show", default: false, null: false
    t.boolean "custom_link1_state", default: false, null: false
    t.string "custom_link1_name"
    t.string "custom_link1_description"
    t.boolean "custom_link1_show", default: false, null: false
    t.boolean "custom_link2_state", default: false, null: false
    t.string "custom_link2_name"
    t.string "custom_link2_description"
    t.boolean "custom_link2_show", default: false, null: false
    t.boolean "custom_link3_state", default: false, null: false
    t.string "custom_link3_name"
    t.string "custom_link3_description"
    t.boolean "custom_link3_show", default: false, null: false
    t.boolean "custom_bool1_state", default: false, null: false
    t.string "custom_bool1_name"
    t.string "custom_bool1_description"
    t.boolean "custom_bool1_show", default: false, null: false
    t.boolean "custom_bool2_state", default: false, null: false
    t.string "custom_bool2_name"
    t.string "custom_bool2_description"
    t.boolean "custom_bool2_show", default: false, null: false
    t.boolean "custom_bool3_state", default: false, null: false
    t.string "custom_bool3_name"
    t.string "custom_bool3_description"
    t.boolean "custom_bool3_show", default: false, null: false
    t.index ["category_id"], name: "index_inventories_on_category_id"
    t.index ["created_at"], name: "index_inventories_on_created_at"
    t.index ["creator_id"], name: "index_inventories_on_creator_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "inventory_id", null: false
    t.bigint "created_by_id", null: false
    t.string "custom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "custom_string1"
    t.text "custom_text1"
    t.decimal "custom_int1"
    t.string "custom_link1"
    t.boolean "custom_bool1"
    t.string "custom_string2"
    t.text "custom_text2"
    t.decimal "custom_int2"
    t.string "custom_link2"
    t.boolean "custom_bool2"
    t.string "custom_string3"
    t.text "custom_text3"
    t.decimal "custom_int3"
    t.string "custom_link3"
    t.boolean "custom_bool3"
    t.index ["created_by_id"], name: "index_items_on_created_by_id"
    t.index ["inventory_id", "custom_id"], name: "index_items_on_inventory_id_and_custom_id", unique: true
    t.index ["inventory_id"], name: "index_items_on_inventory_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.integer "status", default: 0, null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "provider"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "inventories", "categories"
  add_foreign_key "inventories", "users", column: "creator_id"
  add_foreign_key "items", "inventories"
  add_foreign_key "items", "users", column: "created_by_id"
  add_foreign_key "sessions", "users"
end
