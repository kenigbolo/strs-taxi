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

ActiveRecord::Schema.define(version: 20161213030658) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "driver_id"
    t.integer  "location_id"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["location_id"], name: "index_bookings_on_location_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "car_model"
    t.string   "car_color"
    t.string   "plate_number"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "status"
    t.float    "current_location"
    t.float    "current_location_lat"
    t.float    "current_location_long"
    t.index ["user_id"], name: "index_drivers_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "pickup_address"
    t.string   "dropoff_address"
    t.float    "pickup_lat"
    t.float    "pickup_long"
    t.float    "dropoff_lat"
    t.float    "dropoff_long"
    t.string   "distance_between"
    t.float    "cost"
    t.string   "time"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "password_digest"
    t.string   "user_type"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "token"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
  end

end
