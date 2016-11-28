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

ActiveRecord::Schema.define(version: 20161128122340) do

  create_table "customers", force: :cascade do |t|
    t.string   "email",            default: ""
    t.string   "credit_card",      default: ""
    t.integer  "card_expiry_date"
    t.integer  "card_expiry_year"
    t.integer  "card_cvv"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "address",          default: ""
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",       default: ""
    t.decimal  "price",      default: "0.0"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.integer  "qty",        default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "total_price",          default: "0.0"
    t.decimal  "price_after_discount", default: "0.0"
    t.integer  "customer_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "state",                default: "placed"
    t.string   "ref_no",               default: ""
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "promocodes", force: :cascade do |t|
    t.string   "name",                 default: ""
    t.string   "promo_type",           default: ""
    t.decimal  "value",                default: "0.0"
    t.boolean  "used_in_conjuncation", default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.integer "order_id"
    t.integer "promocode_id"
    t.index ["order_id"], name: "index_promotions_on_order_id"
    t.index ["promocode_id"], name: "index_promotions_on_promocode_id"
  end

end
