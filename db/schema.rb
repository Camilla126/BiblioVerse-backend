# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_29_000623) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "author", null: false
    t.string "cover_url"
    t.datetime "created_at", null: false
    t.string "genre"
    t.datetime "published_at"
    t.text "synopsis"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["genre"], name: "index_books_on_genre"
    t.index ["title"], name: "index_books_on_title"
  end

  create_table "chapters", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "position", default: 0, null: false
    t.datetime "published_at"
    t.bigint "story_id", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id", "position"], name: "index_chapters_on_story_id_and_position"
    t.index ["story_id"], name: "index_chapters_on_story_id"
  end

  create_table "follows", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "followed_id", null: false
    t.bigint "follower_id", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "book_id"
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "kind", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["book_id"], name: "index_posts_on_book_id"
    t.index ["created_at"], name: "index_posts_on_created_at"
    t.index ["kind"], name: "index_posts_on_kind"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "cover_url"
    t.datetime "created_at", null: false
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["status"], name: "index_stories_on_status"
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "user_books", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.integer "current_page", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.integer "total_pages"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["book_id"], name: "index_user_books_on_book_id"
    t.index ["status"], name: "index_user_books_on_status"
    t.index ["user_id", "book_id"], name: "index_user_books_on_user_id_and_book_id", unique: true
    t.index ["user_id"], name: "index_user_books_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chapters", "stories"
  add_foreign_key "follows", "users", column: "followed_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "posts", "books"
  add_foreign_key "posts", "users"
  add_foreign_key "stories", "users"
  add_foreign_key "user_books", "books"
  add_foreign_key "user_books", "users"
end
