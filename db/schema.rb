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

ActiveRecord::Schema.define(version: 20200820013358) do

  create_table "answers", force: :cascade do |t|
    t.text "comment"
    t.string "mock_id"
    t.string "mocker_id"
    t.integer "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bolds", force: :cascade do |t|
    t.string "votable_type"
    t.string "votable_id"
    t.string "voter_type"
    t.string "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_bolds_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_bolds_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_bolds_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_bolds_on_voter_type_and_voter_id"
  end

  create_table "conversations", id: :string, limit: 36, force: :cascade do |t|
    t.string "sender_id"
    t.string "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "sqlite_autoindex_conversations_1", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.string "follower_id"
    t.string "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_friendships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_friendships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_friendships_on_follower_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.string "impressionable_id"
    t.string "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "mentions", force: :cascade do |t|
    t.string "mentionee_type"
    t.integer "mentionee_id"
    t.string "mentioner_type"
    t.integer "mentioner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentionee_id", "mentionee_type", "mentioner_id", "mentioner_type"], name: "mentions_mentionee_mentioner_idx", unique: true
    t.index ["mentionee_id", "mentionee_type"], name: "mentions_mentionee_idx"
    t.index ["mentionee_type", "mentionee_id"], name: "index_mentions_on_mentionee_type_and_mentionee_id"
    t.index ["mentioner_id", "mentioner_type"], name: "mentions_mentioner_idx"
    t.index ["mentioner_type", "mentioner_id"], name: "index_mentions_on_mentioner_type_and_mentioner_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.string "mocker_id"
    t.string "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["mocker_id"], name: "index_messages_on_mocker_id"
  end

  create_table "mockers", id: :string, limit: 36, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.string "image"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "provider"
    t.string "uid"
    t.datetime "birthday"
    t.string "slug"
    t.boolean "admin", default: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "coverpage_file_name"
    t.string "coverpage_content_type"
    t.integer "coverpage_file_size"
    t.datetime "coverpage_updated_at"
    t.string "facebook"
    t.string "twitter"
    t.string "instagram"
    t.string "pinterest"
    t.string "youtube"
    t.string "verification"
    t.index ["confirmation_token"], name: "index_mockers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_mockers_on_email", unique: true
    t.index ["id"], name: "sqlite_autoindex_mockers_1", unique: true
    t.index ["reset_password_token"], name: "index_mockers_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_mockers_on_slug", unique: true
  end

  create_table "mocks", id: :string, limit: 36, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mocker_id"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.string "music_file_name"
    t.string "music_content_type"
    t.integer "music_file_size"
    t.datetime "music_updated_at"
    t.string "movie_file_name"
    t.string "movie_content_type"
    t.integer "movie_file_size"
    t.datetime "movie_updated_at"
    t.string "category"
    t.string "credits"
    t.integer "impressions_count", default: 0
    t.index ["id"], name: "sqlite_autoindex_mocks_1", unique: true
    t.index ["mocker_id"], name: "index_mocks_on_mocker_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_id"
    t.string "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.string "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.string "mock_id"
    t.string "mocker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_subscriptions_on_email", unique: true
  end

  create_table "taggings", force: :cascade do |t|
    t.string "tag_id"
    t.string "taggable_type"
    t.string "taggable_id"
    t.string "tagger_type"
    t.string "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.string "votable_id"
    t.string "voter_type"
    t.string "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

end
