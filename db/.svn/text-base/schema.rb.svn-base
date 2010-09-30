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

ActiveRecord::Schema.define(:version => 20100913210439) do

  create_table "activities", :force => true do |t|
    t.date     "activity_date"
    t.integer  "project_id"
    t.string   "service"
    t.string   "detail"
    t.string   "activity_type"
    t.time     "start_time"
    t.time     "end_time"
    t.decimal  "hours",         :precision => 8, :scale => 2, :default => 0.0
    t.string   "bill_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "billing_name"
    t.string   "billing_email"
  end

  create_table "invoices", :force => true do |t|
    t.string   "number"
    t.integer  "user_id"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "sent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "total_hours",         :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "total_cost_internal", :precision => 8, :scale => 2, :default => 0.0
    t.integer  "client_id"
    t.decimal  "total_non_billed",    :precision => 8, :scale => 2, :default => 0.0
  end

  create_table "list_values", :force => true do |t|
    t.integer  "list_id"
    t.integer  "position"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", :force => true do |t|
    t.integer  "position"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer  "client_id"
    t.string   "name"
    t.string   "number"
    t.decimal  "rate_internal", :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "billing_name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "billing_name"
    t.string   "full_name"
    t.text     "prefs"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
