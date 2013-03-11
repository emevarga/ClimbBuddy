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

ActiveRecord::Schema.define(:version => 20121125010516) do

  create_table "climb_data", :force => true do |t|
    t.string   "state"
    t.string   "area"
    t.string   "location_name"
    t.string   "rock_name"
    t.string   "route_name"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "parking_lat"
    t.string   "parking_long"
    t.integer  "skill_level"
    t.string   "climb_type"
    t.integer  "height"
    t.string   "image_url"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
