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

ActiveRecord::Schema[7.2].define(version: 2015_11_20_051517) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "order_items", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.integer "ordering_id"
    t.integer "unit_price"
    t.integer "quantity"
    t.integer "total_price"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["ordering_id"], name: "index_order_items_on_ordering_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_statuses", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "orderings", id: :serial, force: :cascade do |t|
    t.integer "city_id"
    t.integer "order_id"
    t.integer "order_status_id"
    t.string "address"
    t.string "name"
    t.string "phone"
    t.integer "total"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["city_id"], name: "index_orderings_on_city_id"
    t.index ["order_id"], name: "index_orderings_on_order_id"
    t.index ["order_status_id"], name: "index_orderings_on_order_status_id"
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "total"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.boolean "active"
    t.integer "category_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "picture"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  add_foreign_key "order_items", "orderings"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orderings", "cities"
  add_foreign_key "orderings", "order_statuses"
  add_foreign_key "orderings", "orders"
  add_foreign_key "products", "categories"
end
