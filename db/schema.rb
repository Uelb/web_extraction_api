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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140630055904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "centroids", force: true do |t|
    t.float    "color"
    t.float    "background_color"
    t.float    "width"
    t.float    "height"
    t.float    "text_decoration"
    t.float    "font_style"
    t.float    "left_alignment"
    t.float    "top_alignment"
    t.float    "z_index"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "label_id"
    t.float    "padding_l_r"
    t.float    "padding_t_b"
    t.float    "border_horizontal_width"
    t.float    "border_vertical_width"
  end

  create_table "extractions", force: true do |t|
    t.float    "color"
    t.float    "background_color"
    t.float    "width"
    t.float    "height"
    t.float    "text_decoration"
    t.float    "font_style"
    t.float    "left_alignment"
    t.float    "top_alignment"
    t.float    "z_index"
    t.integer  "user_id"
    t.integer  "website_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "padding_l_r"
    t.float    "padding_t_b"
    t.float    "border_horizontal_width"
    t.float    "border_vertical_width"
  end

  add_index "extractions", ["user_id"], name: "index_extractions_on_user_id", using: :btree
  add_index "extractions", ["website_id"], name: "index_extractions_on_website_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.text     "value"
    t.integer  "label_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "image",       default: false, null: false
    t.integer  "parent_id"
    t.integer  "centroid_id"
    t.string   "link"
  end

  add_index "items", ["centroid_id"], name: "index_items_on_centroid_id", using: :btree
  add_index "items", ["label_id"], name: "index_items_on_label_id", using: :btree
  add_index "items", ["parent_id"], name: "index_items_on_parent_id", using: :btree

  create_table "labels", force: true do |t|
    t.string   "value"
    t.integer  "extraction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "container",     default: false
  end

  create_table "statistics", force: true do |t|
    t.integer  "color",                   default: 0
    t.integer  "background_color",        default: 0
    t.integer  "width",                   default: 0
    t.integer  "height",                  default: 0
    t.integer  "text_decoration",         default: 0
    t.integer  "font_style",              default: 0
    t.integer  "left_alignment",          default: 0
    t.integer  "top_alignment",           default: 0
    t.integer  "z_index",                 default: 0
    t.integer  "padding_l_r",             default: 0
    t.integer  "padding_t_b",             default: 0
    t.integer  "border_horizontal_width", default: 0
    t.integer  "border_vertical_width",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "extraction_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "uid"
    t.string   "provider"
    t.string   "provider_token"
    t.string   "nickname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "websites", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
