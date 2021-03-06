# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170103085417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "listing_tags", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "listing_tags", ["listing_id"], name: "index_listing_tags_on_listing_id", using: :btree
  add_index "listing_tags", ["tag_id"], name: "index_listing_tags_on_tag_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.string   "title",           null: false
    t.text     "description"
    t.string   "country"
    t.string   "city"
    t.string   "zip_code"
    t.text     "street_address"
    t.integer  "price_per_night", null: false
    t.integer  "fees"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "verification"
  end

  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "reservation_id"
    t.float    "amount"
    t.date     "executed_at"
    t.string   "braintree_transaction_id"
    t.string   "cardholder_name"
    t.string   "customer_location"
    t.integer  "braintree_customer_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "payments", ["reservation_id"], name: "index_payments_on_reservation_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.date     "from"
    t.date     "to"
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "upload_listings", force: :cascade do |t|
    t.string   "image"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "upload_listings", ["listing_id"], name: "index_upload_listings_on_listing_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.integer  "role"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "authentications", "users"
  add_foreign_key "listing_tags", "listings"
  add_foreign_key "listing_tags", "tags"
  add_foreign_key "listings", "users"
  add_foreign_key "payments", "reservations"
  add_foreign_key "reservations", "listings"
  add_foreign_key "reservations", "users"
  add_foreign_key "upload_listings", "listings"
end
