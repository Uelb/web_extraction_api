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

ActiveRecord::Schema.define(version: 20140331112008) do

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
    t.string   "label"
    t.integer  "website_id"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "centroids", ["website_id"], name: "index_centroids_on_website_id"

  create_table "items", force: true do |t|
    t.string   "value"
    t.integer  "centroid_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["centroid_id"], name: "index_items_on_centroid_id"

  create_table "websites", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
