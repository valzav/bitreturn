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

ActiveRecord::Schema.define(:version => 1) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "platform_id"
    t.integer  "fbapp_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "gplus_id"
    t.string   "token",           :limit => 1024
    t.string   "secret"
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "link"
    t.string   "photo_url"
    t.string   "small_photo_url"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "accounts", ["email"], :name => "index_accounts_on_email"
  add_index "accounts", ["uid"], :name => "index_accounts_on_uid"
  add_index "accounts", ["user_id", "platform_id", "fbapp_id"], :name => "index_accounts_on_user_id_and_platform_id_and_fbapp_id"

  create_table "assets", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bitcoin_blocks", :force => true do |t|
    t.integer  "block_number"
    t.date     "block_date"
    t.datetime "block_time"
    t.string   "target"
    t.float    "difficulty"
    t.float    "ghps"
  end

  add_index "bitcoin_blocks", ["block_number"], :name => "index_bitcoin_blocks_on_block_number"

  create_table "dif_models", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "platforms", :force => true do |t|
    t.string "name"
    t.string "make"
    t.string "link"
    t.string "logo"
    t.string "url_regexp"
    t.string "userpic"
  end

  add_index "platforms", ["name"], :name => "index_platforms_on_name"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.string   "nickname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "photo_url"
    t.string   "small_photo_url"
    t.boolean  "active",              :default => false, :null => false
    t.string   "location"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "info"
    t.string   "website_name"
    t.string   "website_url"
    t.boolean  "admin"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["single_access_token"], :name => "index_users_on_single_access_token"

end
