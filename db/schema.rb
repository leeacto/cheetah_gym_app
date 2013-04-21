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

ActiveRecord::Schema.define(:version => 20130405234332) do

  create_table "daywods", :force => true do |t|
    t.date     "performed"
    t.integer  "wod_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "daywods", ["wod_id"], :name => "index_daily_wods_on_wod_id"

  create_table "results", :force => true do |t|
    t.float    "recd"
    t.integer  "user_id"
    t.integer  "daywod_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "rx"
    t.text     "note"
  end

  add_index "results", ["daywod_id"], :name => "index_results_on_daywod_id"
  add_index "results", ["user_id"], :name => "index_results_on_user_id"

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
