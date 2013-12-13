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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131213145702) do

  create_table "ambience_reviews", :force => true do |t|
    t.integer  "ambience_id"
    t.integer  "restaurant_detail_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "ambience_reviews", ["ambience_id"], :name => "index_ambience_reviews_on_ambience_id"
  add_index "ambience_reviews", ["restaurant_detail_id"], :name => "index_ambience_reviews_on_restaurant_detail_id"

  create_table "ambiences", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attires", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "business_parking_reviews", :force => true do |t|
    t.integer  "business_parking_id"
    t.integer  "restaurant_detail_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "business_parking_reviews", ["business_parking_id"], :name => "index_business_parking_reviews_on_business_parking_id"
  add_index "business_parking_reviews", ["restaurant_detail_id"], :name => "index_business_parking_reviews_on_restaurant_detail_id"

  create_table "business_parkings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "businesses", :force => true do |t|
    t.integer  "country_id",     :null => false
    t.string   "name",           :null => false
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "phone_number"
    t.string   "website"
    t.float    "rating"
    t.integer  "category1_id"
    t.integer  "category2_id"
    t.integer  "category3_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "store_front_id"
  end

  add_index "businesses", ["name"], :name => "index_businesses_on_name"

  create_table "categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cities", ["name"], :name => "index_cities_on_name", :unique => true

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "decisions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "good_for_meal_reviews", :force => true do |t|
    t.integer  "good_for_meal_id"
    t.integer  "restaurant_detail_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "good_for_meal_reviews", ["good_for_meal_id"], :name => "index_good_for_meal_reviews_on_good_for_meal_id"
  add_index "good_for_meal_reviews", ["restaurant_detail_id"], :name => "index_good_for_meal_reviews_on_restaurant_detail_id"

  create_table "good_for_meals", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "helpfuls", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "city_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "locations", ["city_id"], :name => "index_locations_on_city_id"
  add_index "locations", ["name"], :name => "index_locations_on_name", :unique => true

  create_table "neighborhoods", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "location_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "neighborhoods", ["location_id"], :name => "index_neighborhoods_on_location_id"
  add_index "neighborhoods", ["name"], :name => "index_neighborhoods_on_name", :unique => true

  create_table "noise_levels", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photo_details", :force => true do |t|
    t.integer  "photo_id",    :null => false
    t.integer  "helpful_id"
    t.boolean  "store_front"
    t.integer  "user_id",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "photo_details", ["photo_id"], :name => "index_photo_details_on_photo_id"
  add_index "photo_details", ["user_id"], :name => "index_photo_details_on_user_id"

  create_table "photos", :force => true do |t|
    t.string   "img_url",     :null => false
    t.integer  "user_id",     :null => false
    t.integer  "business_id"
    t.string   "caption"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "photos", ["business_id"], :name => "index_photos_on_business_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "price_ranges", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profile_locations", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.string   "name",                          :null => false
    t.string   "address",                       :null => false
    t.boolean  "primary",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "profile_locations", ["user_id"], :name => "index_profile_locations_on_user_id"

  create_table "restaurant_details", :force => true do |t|
    t.integer  "review_id"
    t.integer  "good_for_groups_id"
    t.integer  "noise_level_id"
    t.integer  "price_range_id"
    t.integer  "attire_id"
    t.integer  "good_for_kids_id"
    t.integer  "wifi_id"
    t.integer  "drive_thru_id"
    t.integer  "has_tv_id"
    t.integer  "caters_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "business_id"
    t.text     "body"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reviews", ["business_id"], :name => "index_reviews_on_business_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "sub_categories", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "category_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "sub_categories", ["category_id"], :name => "index_sub_categories_on_category_id"

  create_table "user_bios", :force => true do |t|
    t.string   "headline"
    t.string   "love_name"
    t.string   "not_yelp"
    t.string   "find_me_in"
    t.string   "hometown"
    t.string   "website"
    t.string   "reviews"
    t.string   "secondsite"
    t.string   "book"
    t.string   "concert"
    t.string   "movie"
    t.string   "meal"
    t.string   "dont_tell"
    t.string   "recent_discovery"
    t.string   "crush"
    t.integer  "language_id",      :default => 1
    t.integer  "user_id",                         :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "user_bios", ["user_id"], :name => "index_user_bios_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.date     "birthdate"
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.string   "session_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "img_url"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
