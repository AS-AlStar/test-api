# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_07_184827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.string "user_ip", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "average_rating", default: 0.0, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
    t.index ["user_ip"], name: "index_posts_on_user_ip"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "star", null: false
    t.bigint "post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_ratings_on_post_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "posts_count", default: 0, null: false
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["posts_count"], name: "index_users_on_posts_count"
  end

  add_foreign_key "posts", "users"
  add_foreign_key "ratings", "posts"
end
