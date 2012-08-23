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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120823184904) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "postal_code"
    t.string   "region_code"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "weather_records", :force => true do |t|
    t.integer  "high"
    t.integer  "low"
    t.date     "weather_date"
    t.integer  "chance_of_rain"
    t.datetime "recorded_at"
    t.integer  "weather_service_id"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "weather_services", :force => true do |t|
    t.string   "full_name"
    t.string   "short_name"
    t.string   "homepage_url"
    t.string   "zipcode_url_template"
    t.boolean  "active"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

end
