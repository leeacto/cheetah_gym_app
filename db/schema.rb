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

ActiveRecord::Schema.define(:version => 20130216235621) do

  create_table "daily_wods", :force => true do |t|
    t.date     "performed"
    t.integer  "wod_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "daily_wods", ["wod_id"], :name => "index_daily_wods_on_wod_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin"
  end

  create_table "wods", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.string   "seq"
    t.string   "wod_type"
    t.integer  "baserep"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end