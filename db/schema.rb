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

ActiveRecord::Schema.define(version: 20160602180207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "frames", force: :cascade do |t|
    t.integer  "video_id"
    t.string   "video_timestamp"
    t.decimal  "anger"
    t.decimal  "contempt"
    t.decimal  "disgust"
    t.decimal  "fear"
    t.decimal  "happiness"
    t.decimal  "neutral"
    t.decimal  "sadness"
    t.decimal  "surprise"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "frames", ["video_id"], name: "index_frames_on_video_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "time_length"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "video_file_file_name"
    t.string   "video_file_content_type"
    t.integer  "video_file_file_size"
    t.datetime "video_file_updated_at"
    t.string   "email"
  end

  add_foreign_key "frames", "videos"
end
