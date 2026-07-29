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

ActiveRecord::Schema[8.1].define(version: 2026_07_29_001943) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "icon"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_achievements_on_name", unique: true
  end

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

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.bigint "post_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
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

  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "likeable_id", null: false
    t.string "likeable_type", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable"
    t.index ["user_id", "likeable_type", "likeable_id"], name: "index_likes_on_user_and_likeable", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "actor_id"
    t.datetime "created_at", null: false
    t.integer "kind", null: false
    t.jsonb "payload", default: {}, null: false
    t.boolean "read", default: false, null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["actor_id"], name: "index_notifications_on_actor_id"
    t.index ["created_at"], name: "index_notifications_on_created_at"
    t.index ["user_id", "read"], name: "index_notifications_on_user_id_and_read"
    t.index ["user_id"], name: "index_notifications_on_user_id"
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

  create_table "reviews", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "rating", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id", "book_id"], name: "index_reviews_on_user_id_and_book_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id"
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

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "achievement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "unlocked_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id", "achievement_id"], name: "index_user_achievements_on_user_id_and_achievement_id", unique: true
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
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
    t.string "avatar_url"
    t.text "bio"
    t.string "cover_url"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "handle"
    t.string "location"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.string "website"
    t.index ["handle"], name: "index_users_on_handle", unique: true
  end

  add_foreign_key "chapters", "stories"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "follows", "users", column: "followed_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "likes", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "actor_id"
  add_foreign_key "posts", "books"
  add_foreign_key "posts", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
  add_foreign_key "stories", "users"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "user_books", "books"
  add_foreign_key "user_books", "users"
end
