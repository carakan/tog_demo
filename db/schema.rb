# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091129214402) do

  create_table "abuses", :force => true do |t|
    t.string   "email"
    t.string   "title"
    t.string   "referer"
    t.string   "description"
    t.boolean  "confirmed",     :default => false
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
  end

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["item_type", "item_id"], :name => "index_activities_on_item_type_and_item_id"

  create_table "client_applications", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "support_url"
    t.string   "callback_url"
    t.string   "key",          :limit => 50
    t.string   "secret",       :limit => 50
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_applications", ["key"], :name => "index_client_applications_on_key", :unique => true

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment",                        :default => ""
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentable_type",               :default => "",    :null => false
    t.boolean  "approved",                       :default => false
    t.string   "name"
    t.string   "email"
    t.string   "url"
    t.boolean  "spam",                           :default => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "config", :force => true do |t|
    t.string   "key",        :default => "", :null => false
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "config", ["key"], :name => "key", :unique => true

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "deletable",    :default => false
    t.string   "folder_type"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "inviter_id"
    t.integer  "invited_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "state"
    t.boolean  "private"
    t.boolean  "moderated",                        :default => false
    t.integer  "user_id"
    t.string   "activation_code",    :limit => 40
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "moderator",                     :default => false
    t.string   "state"
    t.string   "activation_code", :limit => 40
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_readings", :force => true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "folder_id"
    t.boolean  "is_read",      :default => false
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_nonces", :force => true do |t|
    t.string   "nonce"
    t.integer  "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_nonces", ["nonce", "timestamp"], :name => "index_oauth_nonces_on_nonce_and_timestamp", :unique => true

  create_table "oauth_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",                  :limit => 20
    t.integer  "client_application_id"
    t.string   "token",                 :limit => 50
    t.string   "secret",                :limit => 50
    t.datetime "authorized_at"
    t.datetime "invalidated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_tokens", ["token"], :name => "index_oauth_tokens_on_token", :unique => true

  create_table "plugin_schema_migrations", :id => false, :force => true do |t|
    t.string "plugin_name"
    t.string "version"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "website"
    t.string   "blog"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "average_rating"
    t.integer  "ratings_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["rateable_id", "rateable_type"], :name => "index_ratings_on_rateable_id_and_rateable_type"

  create_table "shares", :force => true do |t|
    t.integer  "user_id"
    t.string   "shareable_type", :limit => 30
    t.integer  "shareable_id"
    t.string   "shared_to_type", :limit => 30
    t.integer  "shared_to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                       :default => 1
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_ratings", :force => true do |t|
    t.integer  "rating_id"
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_ratings", ["user_id", "rating_id"], :name => "index_user_ratings_on_user_id_and_rating_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "activation_code",           :limit => 40
    t.string   "password_reset_code"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.string   "state",                                   :default => "passive"
    t.boolean  "admin",                                   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
