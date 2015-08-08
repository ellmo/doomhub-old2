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

ActiveRecord::Schema.define(version: 20150808180751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "games", force: true do |t|
    t.string   "name"
    t.string   "default_lumpname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "width"
    t.integer  "height"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "item_accesses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maps", force: true do |t|
    t.integer  "author_id"
    t.integer  "project_id"
    t.string   "lump"
    t.string   "name"
    t.string   "url_name"
    t.string   "slug"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url_name",                       null: false
    t.string   "slug",                           null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
    t.integer  "source_port_id"
    t.integer  "item_access_id"
    t.boolean  "public_view",    default: true,  null: false
    t.boolean  "public_join",    default: false, null: false
    t.datetime "deleted_at"
  end

  add_index "projects", ["game_id"], name: "index_projects_on_game_id", using: :btree
  add_index "projects", ["item_access_id"], name: "index_projects_on_item_access_id", using: :btree
  add_index "projects", ["source_port_id"], name: "index_projects_on_source_port_id", using: :btree

  create_table "source_ports", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "uploadable_id"
    t.string   "uploadable_type"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "archive_file_name"
    t.string   "archive_content_type"
    t.integer  "archive_file_size"
    t.datetime "archive_updated_at"
  end

  create_table "user_roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "login"
    t.datetime "deleted_at"
    t.integer  "admin_level",            default: 0,  null: false
    t.integer  "user_role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_role_id"], name: "index_users_on_user_role_id", using: :btree

end
