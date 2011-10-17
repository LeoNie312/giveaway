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

ActiveRecord::Schema.define(:version => 20111017053302) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connections", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "child_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connections", ["child_id"], :name => "index_connections_on_child_id", :unique => true
  add_index "connections", ["parent_id"], :name => "index_connections_on_parent_id"

  create_table "items", :force => true do |t|
    t.string   "description"
    t.string   "img_link"
    t.integer  "category_id"
    t.boolean  "onshelf",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "onshelf_at"
    t.integer  "owner_id"
  end

  add_index "items", ["category_id"], :name => "index_items_on_category_id"
  add_index "items", ["owner_id"], :name => "index_items_on_owner_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "hp"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

  create_table "wishes", :force => true do |t|
    t.integer  "wanter_id"
    t.integer  "category_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "connected_at"
    t.boolean  "connected",    :default => false
  end

  add_index "wishes", ["category_id"], :name => "index_wishes_on_category_id"
  add_index "wishes", ["item_id"], :name => "index_wishes_on_item_id"
  add_index "wishes", ["wanter_id"], :name => "index_wishes_on_wanter_id"

end
