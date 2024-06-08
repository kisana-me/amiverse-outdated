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

ActiveRecord::Schema[7.0].define(version: 902) do
  create_table "account_achievements", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "achievement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_achievements_on_account_id"
    t.index ["achievement_id"], name: "index_account_achievements_on_achievement_id"
  end

  create_table "account_badges", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "badge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_badges_on_account_id"
    t.index ["badge_id"], name: "index_account_badges_on_badge_id"
  end

  create_table "account_banners", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "banner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_banners_on_account_id"
    t.index ["banner_id"], name: "index_account_banners_on_banner_id"
  end

  create_table "account_curious", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "topic_id", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_curious_on_account_id"
    t.index ["topic_id"], name: "index_account_curious_on_topic_id"
  end

  create_table "account_features", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "topic_id", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_features_on_account_id"
    t.index ["topic_id"], name: "index_account_features_on_topic_id"
  end

  create_table "account_feeds", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "feed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_feeds_on_account_id"
    t.index ["feed_id"], name: "index_account_feeds_on_feed_id"
  end

  create_table "account_icons", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "icon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_icons_on_account_id"
    t.index ["icon_id"], name: "index_account_icons_on_icon_id"
  end

  create_table "account_invitations", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "invitation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_invitations_on_account_id"
    t.index ["invitation_id"], name: "index_account_invitations_on_invitation_id"
  end

  create_table "account_item_impressions", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "item_id", null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_item_impressions_on_account_id"
    t.index ["item_id"], name: "index_account_item_impressions_on_item_id"
  end

  create_table "account_list_relations", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "account_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_list_relations_on_account_id"
    t.index ["account_list_id"], name: "index_account_list_relations_on_account_list_id"
  end

  create_table "account_lists", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "counter", default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_lists_on_account_id"
    t.index ["aid"], name: "index_account_lists_on_aid", unique: true
  end

  create_table "account_permissions", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "permission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_permissions_on_account_id"
    t.index ["permission_id"], name: "index_account_permissions_on_permission_id"
  end

  create_table "account_roles", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_roles_on_account_id"
    t.index ["role_id"], name: "index_account_roles_on_role_id"
  end

  create_table "account_tags", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_tags_on_account_id"
    t.index ["tag_id"], name: "index_account_tags_on_tag_id"
  end

  create_table "accounts", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.string "name_id", null: false
    t.boolean "sensitive", default: false, null: false
    t.string "caution_message", default: "", null: false
    t.integer "online_status", limit: 1, default: 0, null: false
    t.integer "online_visibility", limit: 1, default: 0, null: false
    t.datetime "last_online"
    t.integer "layout_type", limit: 1, default: 0, null: false
    t.text "description", default: "", null: false
    t.integer "render_type", limit: 1, default: 0, null: false
    t.text "additional_informations", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.string "location", default: "", null: false
    t.date "birth"
    t.integer "birth_year_visibility", limit: 1, default: 0, null: false
    t.integer "birth_month_visibility", limit: 1, default: 0, null: false
    t.integer "birth_day_visibility", limit: 1, default: 0, null: false
    t.text "pinned_items", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.integer "language", limit: 1, default: 0, null: false
    t.integer "followers_visibility", limit: 1, default: 0, null: false
    t.integer "following_visibility", limit: 1, default: 0, null: false
    t.integer "reactions_visibility", limit: 1, default: 0, null: false
    t.boolean "discoverable", default: true, null: false
    t.boolean "auto_accept_follow", default: true, null: false
    t.string "email", default: "", null: false
    t.boolean "email_verified", default: false, null: false
    t.string "login_id", default: "", null: false
    t.boolean "use_login_id", default: false, null: false
    t.integer "usage_type", limit: 1, default: 0, null: false
    t.text "defaults", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "settings", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.string "icon_key", default: "", null: false
    t.string "banner_key", default: "", null: false
    t.bigint "followers_counter", default: 0, null: false
    t.bigint "following_counter", default: 0, null: false
    t.bigint "items_counter", default: 0, null: false
    t.bigint "reactions_counter", default: 0, null: false
    t.bigint "reacted_counter", default: 0, null: false
    t.bigint "viewed_counter", default: 0, null: false
    t.text "word_mutes", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "mutes", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "blocks", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "permissions", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.datetime "feed_last_created_at"
    t.datetime "following_feed_last_created_at"
    t.text "checker", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.integer "score", default: 0, null: false
    t.bigint "used_storage_size", default: 0, null: false
    t.bigint "max_storage_size", default: 1000000000, null: false
    t.string "password_digest"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.boolean "foreigner", default: false, null: false
    t.boolean "activitypub", default: false, null: false
    t.boolean "ap_status", default: false, null: false
    t.string "ap_uri", default: "", null: false
    t.string "ap_url", default: "", null: false
    t.datetime "ap_last_fetched_at"
    t.text "ap_meta", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.text "ap_public_key", default: "", null: false
    t.text "ap_private_key", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid", "name_id", "ap_uri"], name: "index_accounts_on_aid_and_name_id_and_ap_uri", unique: true
    t.check_constraint "json_valid(`additional_informations`)", name: "additional_informations"
    t.check_constraint "json_valid(`ap_meta`)", name: "ap_meta"
    t.check_constraint "json_valid(`blocks`)", name: "blocks"
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`checker`)", name: "checker"
    t.check_constraint "json_valid(`defaults`)", name: "defaults"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`mutes`)", name: "mutes"
    t.check_constraint "json_valid(`permissions`)", name: "permissions"
    t.check_constraint "json_valid(`pinned_items`)", name: "pinned_items"
    t.check_constraint "json_valid(`settings`)", name: "settings"
    t.check_constraint "json_valid(`word_mutes`)", name: "word_mutes"
  end

  create_table "achievements", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.string "original_key", default: "", null: false
    t.text "variants", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.bigint "associated_counter", default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid"], name: "index_achievements_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`variants`)", name: "variants"
  end

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "audios", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "render_type", limit: 1, default: 0, null: false
    t.boolean "sensitive", default: false, null: false
    t.string "caution_message", default: "", null: false
    t.string "original_key", default: "", null: false
    t.text "variants", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.integer "visibility", limit: 1, default: 0, null: false
    t.integer "limitation", limit: 1, default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.bigint "data_size", default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_audios_on_account_id"
    t.index ["aid"], name: "index_audios_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`variants`)", name: "variants"
  end

  create_table "badges", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.string "original_key", default: "", null: false
    t.text "variants", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.bigint "associated_counter", default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid"], name: "index_badges_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`variants`)", name: "variants"
  end

  create_table "banners", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "render_type", limit: 1, default: 0, null: false
    t.boolean "sensitive", default: false, null: false
    t.string "caution_message", default: "", null: false
    t.string "original_key", default: "", null: false
    t.text "variants", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.integer "visibility", limit: 1, default: 0, null: false
    t.integer "limitation", limit: 1, default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.bigint "data_size", default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_banners_on_account_id"
    t.index ["aid"], name: "index_banners_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`variants`)", name: "variants"
  end

  create_table "blocks", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "blocked", null: false
    t.bigint "blocker", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked"], name: "fk_rails_09e091176d"
    t.index ["blocker"], name: "fk_rails_0d53fdd4e5"
  end

  create_table "canvases", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "render_type", limit: 1, default: 0, null: false
    t.text "canvas_data", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.integer "canvas_type", limit: 1, default: 0, null: false
    t.boolean "sensitive", default: false, null: false
    t.string "caution_message", default: "", null: false
    t.string "original_key", default: "", null: false
    t.text "variants", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.integer "visibility", limit: 1, default: 0, null: false
    t.integer "limitation", limit: 1, default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.bigint "data_size", default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_canvases_on_account_id"
    t.index ["aid"], name: "index_canvases_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`canvas_data`)", name: "canvas_data"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`variants`)", name: "variants"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.bigint "associated_counter", default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid"], name: "index_categories_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
  end

  create_table "clients", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "client_digest", null: false
    t.bigint "primary_session", default: 0, null: false
    t.string "name", default: "", null: false
    t.string "ip_address", default: "", null: false
    t.string "user_agent", default: "", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_clients_on_uuid", unique: true
  end

  create_table "diffusions", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "diffused", null: false
    t.bigint "diffuser", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diffused"], name: "fk_rails_847aa8acdd"
    t.index ["diffuser"], name: "fk_rails_5248f1462e"
  end

  create_table "emoji_categories", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "emoji_type", null: false
    t.bigint "emoji_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_emoji_categories_on_category_id"
    t.index ["emoji_type", "emoji_id"], name: "index_emoji_categories_on_emoji"
  end

  create_table "emojis", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.string "name_id", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "usage_type", limit: 1, default: 0, null: false
    t.boolean "sensitive", default: false, null: false
    t.string "caution_message", default: "", null: false
    t.string "original_key", default: "", null: false
    t.text "variants", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_emojis_on_account_id"
    t.index ["aid", "name_id"], name: "index_emojis_on_aid_and_name_id", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`variants`)", name: "variants"
  end

  create_table "feeds", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.integer "feed_type", limit: 1, default: 0, null: false
    t.integer "usage_type", limit: 1, default: 0, null: false
    t.text "data", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid"], name: "index_feeds_on_aid", unique: true
    t.check_constraint "json_valid(`data`)", name: "data"
  end

  create_table "follows", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "followed_id", null: false
    t.bigint "follower_id", null: false
    t.string "uid", default: "", null: false
    t.boolean "accepted", default: false, null: false
    t.datetime "accepted_at"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "fk_rails_5ef72a3867"
    t.index ["follower_id"], name: "fk_rails_622d34a301"
  end

  create_table "icons", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "render_type", limit: 1, default: 0, null: false
    t.boolean "sensitive", default: false, null: false
    t.string "caution_message", default: "", null: false
    t.string "original_key", default: "", null: false
    t.text "variants", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.integer "visibility", limit: 1, default: 0, null: false
    t.integer "limitation", limit: 1, default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.bigint "data_size", default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_icons_on_account_id"
    t.index ["aid"], name: "index_icons_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`variants`)", name: "variants"
  end

  create_table "images", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "render_type", limit: 1, default: 0, null: false
    t.boolean "sensitive", default: false, null: false
    t.string "caution_message", default: "", null: false
    t.string "original_key", default: "", null: false
    t.text "variants", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.integer "visibility", limit: 1, default: 0, null: false
    t.integer "limitation", limit: 1, default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.bigint "data_size", default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_images_on_account_id"
    t.index ["aid"], name: "index_images_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`variants`)", name: "variants"
  end

  create_table "invitations", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.string "code", null: false
    t.integer "uses", default: 0, null: false
    t.integer "max_uses", default: 1, null: false
    t.datetime "expires_at"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_invitations_on_account_id"
    t.index ["aid", "code"], name: "index_invitations_on_aid_and_code", unique: true
  end

  create_table "item_audios", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "audio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audio_id"], name: "index_item_audios_on_audio_id"
    t.index ["item_id"], name: "index_item_audios_on_item_id"
  end

  create_table "item_canvases", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "canvas_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canvas_id"], name: "index_item_canvases_on_canvas_id"
    t.index ["item_id"], name: "index_item_canvases_on_item_id"
  end

  create_table "item_images", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "image_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_item_images_on_image_id"
    t.index ["item_id"], name: "index_item_images_on_item_id"
  end

  create_table "item_list_relations", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "item_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_list_relations_on_item_id"
    t.index ["item_list_id"], name: "index_item_list_relations_on_item_list_id"
  end

  create_table "item_lists", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "counter", default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_item_lists_on_account_id"
    t.index ["aid"], name: "index_item_lists_on_aid", unique: true
  end

  create_table "item_tags", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_tags_on_item_id"
    t.index ["tag_id"], name: "index_item_tags_on_tag_id"
  end

  create_table "item_topics", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "topic_id", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_topics_on_item_id"
    t.index ["topic_id"], name: "index_item_topics_on_topic_id"
  end

  create_table "item_videos", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_videos_on_item_id"
    t.index ["video_id"], name: "index_item_videos_on_video_id"
  end

  create_table "items", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.text "content", default: "", null: false
    t.boolean "sensitive", default: false, null: false
    t.string "caution_message", default: "", null: false
    t.boolean "silent", default: false, null: false
    t.integer "render_type", limit: 1, default: 0, null: false
    t.integer "layout_type", limit: 1, default: 0, null: false
    t.integer "visibility", limit: 1, default: 0, null: false
    t.integer "usage_type", limit: 1, default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.integer "language", limit: 1, default: 0, null: false
    t.bigint "viewed_counter", default: 0, null: false
    t.integer "replied_counter", default: 0, null: false
    t.integer "diffused_counter", default: 0, null: false
    t.integer "quoted_counter", default: 0, null: false
    t.integer "reacted_counter", default: 0, null: false
    t.integer "listed_counter", default: 0, null: false
    t.text "cache", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.datetime "last_cached_at"
    t.integer "score", default: 0, null: false
    t.text "meta", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.boolean "foreign", default: false, null: false
    t.boolean "activitypub", default: false, null: false
    t.boolean "ap_status", default: false, null: false
    t.string "ap_uri", default: "", null: false
    t.string "ap_url", default: "", null: false
    t.datetime "ap_last_fetched_at"
    t.text "ap_meta", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_items_on_account_id"
    t.index ["aid"], name: "index_items_on_aid", unique: true
    t.check_constraint "json_valid(`ap_meta`)", name: "ap_meta"
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
  end

  create_table "mentions", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_mentions_on_account_id"
    t.index ["item_id"], name: "index_mentions_on_item_id"
  end

  create_table "message_groups", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "counter", default: 0, null: false
    t.boolean "only", default: false, null: false
    t.boolean "private", default: false, null: false
    t.boolean "message", default: false, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_message_groups_on_account_id"
    t.index ["aid"], name: "index_message_groups_on_aid", unique: true
  end

  create_table "messages", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "message_group_id", null: false
    t.string "uuid", null: false
    t.string "kind", default: "", null: false
    t.text "content", default: "", null: false
    t.integer "read", default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_messages_on_account_id"
    t.index ["message_group_id"], name: "index_messages_on_message_group_id"
  end

  create_table "mutes", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "muted", null: false
    t.bigint "muter", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["muted"], name: "fk_rails_bd2bac489c"
    t.index ["muter"], name: "fk_rails_9f098a6341"
  end

  create_table "notifications", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "uuid", null: false
    t.string "message", default: "", null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_notifications_on_account_id"
  end

  create_table "permissions", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.text "properties", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.bigint "associated_counter", default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid"], name: "index_permissions_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`properties`)", name: "properties"
  end

  create_table "polymorphic_audios", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.bigint "audio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audio_id"], name: "index_polymorphic_audios_on_audio_id"
    t.index ["target_type", "target_id"], name: "index_polymorphic_audios_on_target"
  end

  create_table "polymorphic_banners", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.bigint "banner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banner_id"], name: "index_polymorphic_banners_on_banner_id"
    t.index ["target_type", "target_id"], name: "index_polymorphic_banners_on_target"
  end

  create_table "polymorphic_feeds", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.bigint "feed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feed_id"], name: "index_polymorphic_feeds_on_feed_id"
    t.index ["target_type", "target_id"], name: "index_polymorphic_feeds_on_target"
  end

  create_table "polymorphic_icons", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.bigint "icon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["icon_id"], name: "index_polymorphic_icons_on_icon_id"
    t.index ["target_type", "target_id"], name: "index_polymorphic_icons_on_target"
  end

  create_table "polymorphic_images", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.bigint "image_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_polymorphic_images_on_image_id"
    t.index ["target_type", "target_id"], name: "index_polymorphic_images_on_target"
  end

  create_table "polymorphic_reactions", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "emoji_id", null: false
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.integer "usage_type", limit: 1, default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_polymorphic_reactions_on_account_id"
    t.index ["emoji_id"], name: "index_polymorphic_reactions_on_emoji_id"
    t.index ["target_type", "target_id"], name: "index_polymorphic_reactions_on_target"
  end

  create_table "polymorphic_tags", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_polymorphic_tags_on_tag_id"
    t.index ["target_type", "target_id"], name: "index_polymorphic_tags_on_target"
  end

  create_table "polymorphic_topics", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.bigint "topic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id"], name: "index_polymorphic_topics_on_target"
    t.index ["topic_id"], name: "index_polymorphic_topics_on_topic_id"
  end

  create_table "polymorphic_videos", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id"], name: "index_polymorphic_videos_on_target"
    t.index ["video_id"], name: "index_polymorphic_videos_on_video_id"
  end

  create_table "quotes", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "quoted_id", null: false
    t.bigint "quoter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quoted_id"], name: "fk_rails_a493216fab"
    t.index ["quoter_id"], name: "fk_rails_83c38854a4"
  end

  create_table "reactions", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "emoji_id", null: false
    t.bigint "item_id", null: false
    t.integer "usage_type", limit: 1, default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_reactions_on_account_id"
    t.index ["emoji_id"], name: "index_reactions_on_emoji_id"
    t.index ["item_id"], name: "index_reactions_on_item_id"
  end

  create_table "read_items", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "item_id", null: false
    t.integer "counter", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_read_items_on_account_id"
    t.index ["item_id"], name: "index_read_items_on_item_id"
  end

  create_table "read_messages", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_read_messages_on_account_id"
    t.index ["message_id"], name: "index_read_messages_on_message_id"
  end

  create_table "replies", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "replied_id", null: false
    t.bigint "replier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["replied_id"], name: "fk_rails_ed89900097"
    t.index ["replier_id"], name: "fk_rails_20e81e0ffe"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.string "name_id", default: "", null: false
    t.text "description", default: "", null: false
    t.bigint "associated_counter", default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid", "name_id"], name: "index_roles_on_aid_and_name_id", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
  end

  create_table "server_properties", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "server_name", default: "Amiverse", null: false
    t.string "server_version", default: "v.0.0.5", null: false
    t.text "server_description", default: "", null: false
    t.boolean "open_registrations", default: false, null: false
    t.text "languages", size: :long, default: "[\"ja\"]", null: false, collation: "utf8mb4_bin"
    t.string "theme_color", default: "#22ff22", null: false
    t.text "urls", size: :long, default: "[\"https://amiverse.net/\"]", null: false, collation: "utf8mb4_bin"
    t.text "others", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.string "maintainer_name", default: "Amiverse Net", null: false
    t.string "maintainer_email", default: "amiverse@amiverse.net", null: false
    t.bigint "accounts", default: 0, null: false
    t.bigint "items", default: 0, null: false
    t.bigint "images", default: 0, null: false
    t.bigint "audios", default: 0, null: false
    t.bigint "videos", default: 0, null: false
    t.bigint "emojis", default: 0, null: false
    t.bigint "reactions", default: 0, null: false
    t.text "meta", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.datetime "published_at"
    t.boolean "activitypub", default: false, null: false
    t.text "ap_meta", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.integer "trend_interval", default: 30, null: false
    t.integer "trend_samplings", default: 200, null: false
    t.integer "trend_search_words", default: 100, null: false
    t.boolean "ga4", default: true, null: false
    t.string "ga4_id", default: "VP5CN519Q8", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "json_valid(`ap_meta`)", name: "ap_meta"
    t.check_constraint "json_valid(`languages`)", name: "languages"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`others`)", name: "others"
    t.check_constraint "json_valid(`urls`)", name: "urls"
  end

  create_table "sessions", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "client_id", null: false
    t.string "uuid", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_sessions_on_account_id"
    t.index ["client_id"], name: "index_sessions_on_client_id"
  end

  create_table "tags", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.bigint "associated_counter", default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid"], name: "index_tags_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
  end

  create_table "topics", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.bigint "associated_counter", default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid"], name: "index_topics_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
  end

  create_table "trend_words", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "trend_id", null: false
    t.bigint "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trend_id"], name: "index_trend_words_on_trend_id"
    t.index ["word_id"], name: "index_trend_words_on_word_id"
  end

  create_table "trends", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.text "words", size: :long, default: "{}", null: false, collation: "utf8mb4_bin"
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid"], name: "index_trends_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`words`)", name: "words"
  end

  create_table "videos", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.integer "render_type", limit: 1, default: 0, null: false
    t.boolean "sensitive", default: false, null: false
    t.string "caution_message", default: "", null: false
    t.string "original_key", default: "", null: false
    t.text "variants", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.integer "visibility", limit: 1, default: 0, null: false
    t.integer "limitation", limit: 1, default: 0, null: false
    t.integer "status", limit: 1, default: 0, null: false
    t.text "meta", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.text "cache", size: :long, default: "[]", null: false, collation: "utf8mb4_bin"
    t.bigint "data_size", default: 0, null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_videos_on_account_id"
    t.index ["aid"], name: "index_videos_on_aid", unique: true
    t.check_constraint "json_valid(`cache`)", name: "cache"
    t.check_constraint "json_valid(`meta`)", name: "meta"
    t.check_constraint "json_valid(`variants`)", name: "variants"
  end

  create_table "words", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.string "aid", null: false
    t.string "name", default: "", null: false
    t.text "description", default: "", null: false
    t.bigint "counter", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aid"], name: "index_words_on_aid", unique: true
  end

  add_foreign_key "account_achievements", "accounts"
  add_foreign_key "account_achievements", "achievements"
  add_foreign_key "account_badges", "accounts"
  add_foreign_key "account_badges", "badges"
  add_foreign_key "account_banners", "accounts"
  add_foreign_key "account_banners", "banners"
  add_foreign_key "account_curious", "accounts"
  add_foreign_key "account_curious", "topics"
  add_foreign_key "account_features", "accounts"
  add_foreign_key "account_features", "topics"
  add_foreign_key "account_feeds", "accounts"
  add_foreign_key "account_feeds", "feeds"
  add_foreign_key "account_icons", "accounts"
  add_foreign_key "account_icons", "icons"
  add_foreign_key "account_invitations", "accounts"
  add_foreign_key "account_invitations", "invitations"
  add_foreign_key "account_item_impressions", "accounts"
  add_foreign_key "account_item_impressions", "items"
  add_foreign_key "account_list_relations", "account_lists"
  add_foreign_key "account_list_relations", "accounts"
  add_foreign_key "account_lists", "accounts"
  add_foreign_key "account_permissions", "accounts"
  add_foreign_key "account_permissions", "permissions"
  add_foreign_key "account_roles", "accounts"
  add_foreign_key "account_roles", "roles"
  add_foreign_key "account_tags", "accounts"
  add_foreign_key "account_tags", "tags"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "audios", "accounts"
  add_foreign_key "banners", "accounts"
  add_foreign_key "blocks", "accounts", column: "blocked"
  add_foreign_key "blocks", "accounts", column: "blocker"
  add_foreign_key "canvases", "accounts"
  add_foreign_key "diffusions", "items", column: "diffused"
  add_foreign_key "diffusions", "items", column: "diffuser"
  add_foreign_key "emoji_categories", "categories"
  add_foreign_key "emojis", "accounts"
  add_foreign_key "follows", "accounts", column: "followed_id"
  add_foreign_key "follows", "accounts", column: "follower_id"
  add_foreign_key "icons", "accounts"
  add_foreign_key "images", "accounts"
  add_foreign_key "invitations", "accounts"
  add_foreign_key "item_audios", "audios"
  add_foreign_key "item_audios", "items"
  add_foreign_key "item_canvases", "canvases"
  add_foreign_key "item_canvases", "items"
  add_foreign_key "item_images", "images"
  add_foreign_key "item_images", "items"
  add_foreign_key "item_list_relations", "item_lists"
  add_foreign_key "item_list_relations", "items"
  add_foreign_key "item_lists", "accounts"
  add_foreign_key "item_tags", "items"
  add_foreign_key "item_tags", "tags"
  add_foreign_key "item_topics", "items"
  add_foreign_key "item_topics", "topics"
  add_foreign_key "item_videos", "items"
  add_foreign_key "item_videos", "videos"
  add_foreign_key "items", "accounts"
  add_foreign_key "mentions", "accounts"
  add_foreign_key "mentions", "items"
  add_foreign_key "message_groups", "accounts"
  add_foreign_key "messages", "accounts"
  add_foreign_key "messages", "message_groups"
  add_foreign_key "mutes", "accounts", column: "muted"
  add_foreign_key "mutes", "accounts", column: "muter"
  add_foreign_key "notifications", "accounts"
  add_foreign_key "polymorphic_audios", "audios"
  add_foreign_key "polymorphic_banners", "banners"
  add_foreign_key "polymorphic_feeds", "feeds"
  add_foreign_key "polymorphic_icons", "icons"
  add_foreign_key "polymorphic_images", "images"
  add_foreign_key "polymorphic_reactions", "accounts"
  add_foreign_key "polymorphic_reactions", "emojis"
  add_foreign_key "polymorphic_tags", "tags"
  add_foreign_key "polymorphic_topics", "topics"
  add_foreign_key "polymorphic_videos", "videos"
  add_foreign_key "quotes", "items", column: "quoted_id"
  add_foreign_key "quotes", "items", column: "quoter_id"
  add_foreign_key "reactions", "accounts"
  add_foreign_key "reactions", "emojis"
  add_foreign_key "reactions", "items"
  add_foreign_key "read_items", "accounts"
  add_foreign_key "read_items", "items"
  add_foreign_key "read_messages", "accounts"
  add_foreign_key "read_messages", "messages"
  add_foreign_key "replies", "items", column: "replied_id"
  add_foreign_key "replies", "items", column: "replier_id"
  add_foreign_key "sessions", "accounts"
  add_foreign_key "sessions", "clients"
  add_foreign_key "trend_words", "trends"
  add_foreign_key "trend_words", "words"
  add_foreign_key "videos", "accounts"
end
