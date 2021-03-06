# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100905105428) do

  create_table "dislikes", :force => true do |t|
    t.integer  "name_id",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dislikes", ["name_id"], :name => "index_dislikes_on_name_id"
  add_index "dislikes", ["user_id"], :name => "index_dislikes_on_user_id"

  create_table "likes", :force => true do |t|
    t.integer  "name_id",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["name_id"], :name => "index_likes_on_name_id"
  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"

  create_table "names", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "likes_count",    :default => 0
    t.integer  "dislikes_count", :default => 0
  end

  add_index "names", ["created_at"], :name => "index_names_on_created_at"
  add_index "names", ["dislikes_count"], :name => "index_names_on_dislikes_count"
  add_index "names", ["likes_count"], :name => "index_names_on_likes_count"
  add_index "names", ["name"], :name => "index_names_on_name"
  add_index "names", ["user_id"], :name => "index_names_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.string   "fb_name"
    t.integer  "facebook_uid",        :limit => 8
    t.integer  "login_count",                      :default => 0
    t.integer  "failed_login_count",               :default => 0
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "anonymous",                        :default => true
  end

  create_table "users_old", :force => true do |t|
    t.string   "login",                                           :null => false
    t.string   "crypted_password",                                :null => false
    t.string   "password_salt",                                   :null => false
    t.string   "persistence_token",                               :null => false
    t.string   "single_access_token",                             :null => false
    t.string   "perishable_token",                                :null => false
    t.integer  "login_count",                      :default => 0, :null => false
    t.integer  "failed_login_count",               :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "fb_name"
    t.integer  "facebook_uid",        :limit => 8
  end

  add_index "users_old", ["login"], :name => "index_users_on_login"

end
