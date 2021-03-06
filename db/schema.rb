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

ActiveRecord::Schema.define(:version => 20130908111122) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "max",        :default => 10000
    t.integer  "min",        :default => 0
    t.integer  "ideal",      :default => 10
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.integer  "activity_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "users"
  end

  add_index "events", ["activity_id"], :name => "index_events_on_activity_id"

  create_table "preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.integer  "event_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "times"
    t.integer  "interest",    :default => 1
    t.integer  "repeats",     :default => 1
    t.float    "max_time",    :default => 3600.0
  end

  add_index "preferences", ["activity_id"], :name => "index_preferences_on_activity_id"
  add_index "preferences", ["event_id"], :name => "index_preferences_on_event_id"
  add_index "preferences", ["user_id"], :name => "index_preferences_on_user_id"

  create_table "user_sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_sessions", ["session_id"], :name => "index_user_sessions_on_session_id"
  add_index "user_sessions", ["updated_at"], :name => "index_user_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "username",                         :null => false
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.integer  "login_count",       :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "email"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["username"], :name => "index_users_on_username"

end
