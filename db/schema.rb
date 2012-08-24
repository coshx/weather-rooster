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

ActiveRecord::Schema.define(:version => 20120824050917) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "postal_code"
    t.string   "region_code"
    t.string   "station_id"
    t.string   "timezone"
  end

  create_table "current_forecasts", :force => true do |t|
    t.integer  "weather_service_id"
    t.integer  "city_id"
    t.integer  "current_temp"
    t.integer  "day_0_high"
    t.integer  "day_0_low"
    t.string   "day_0_string"
    t.integer  "day_1_high"
    t.integer  "day_1_low"
    t.string   "day_1_string"
    t.integer  "day_2_high"
    t.integer  "day_2_low"
    t.string   "day_2_string"
    t.integer  "day_3_high"
    t.integer  "day_3_low"
    t.string   "day_3_string"
    t.integer  "day_4_high"
    t.integer  "day_4_low"
    t.string   "day_4_string"
    t.integer  "day_5_high"
    t.integer  "day_5_low"
    t.string   "day_5_string"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.datetime "current_at"
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
    t.integer  "city_id"
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
