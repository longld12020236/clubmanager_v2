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

ActiveRecord::Schema.define(version: 20161221163747) do

  create_table "activities", force: :cascade do |t|
    t.string   "action"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.integer  "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_albums_on_club_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"
  end

  create_table "club_requests", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "action"
    t.boolean  "approve",         default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["organization_id"], name: "index_club_requests_on_organization_id"
    t.index ["user_id"], name: "index_club_requests_on_user_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.string   "image"
    t.integer  "chatwork"
    t.string   "notification"
    t.string   "description"
    t.integer  "money",           default: 0
    t.float    "rating",          default: 0.0
    t.boolean  "is_active",       default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["organization_id"], name: "index_clubs_on_organization_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "news_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_id"], name: "index_comments_on_news_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "event_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "club_id"
    t.string   "name"
    t.text     "description"
    t.integer  "expense",     default: 0
    t.date     "date_start"
    t.string   "duration"
    t.string   "location"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["club_id"], name: "index_event_requests_on_club_id"
    t.index ["user_id"], name: "index_event_requests_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "expense",     default: 0
    t.integer  "club_id"
    t.date     "date_start"
    t.string   "duration"
    t.string   "location"
    t.integer  "number_like", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["club_id"], name: "index_events_on_club_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.integer  "album_id"
    t.integer  "user_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_images_on_album_id"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "approve",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["event_id"], name: "index_news_on_event_id"
    t.index ["user_id"], name: "index_news_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "phone"
    t.string   "email"
    t.string   "location"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "category_request_id"
    t.integer  "user_id"
    t.integer  "target_id"
    t.string   "target_type"
    t.string   "content"
    t.date     "date_start"
    t.string   "duration"
    t.string   "location"
    t.boolean  "approve",             default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["category_request_id"], name: "index_requests_on_category_request_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "user_clubs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "club_id"
    t.boolean  "is_manager", default: false
    t.boolean  "status"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["club_id"], name: "index_user_clubs_on_club_id"
    t.index ["user_id"], name: "index_user_clubs_on_user_id"
  end

  create_table "user_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_user_events_on_club_id"
    t.index ["event_id"], name: "index_user_events_on_event_id"
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "organization_id"
    t.string   "full_name"
    t.string   "avatar"
    t.string   "phone"
    t.string   "chatwork"
    t.integer  "role"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
