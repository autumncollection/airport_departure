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

ActiveRecord::Schema.define(version: 2019_12_09_214402) do

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.float "temperature"
    t.time "time"
    t.index ["name"], name: "index_cities_on_name"
  end

  create_table "flights", force: :cascade do |t|
    t.string "code"
    t.time "time"
    t.index ["code"], name: "index_flights_on_code"
  end

  create_table "flights_cities", force: :cascade do |t|
    t.integer "flight_id"
    t.integer "city_id"
    t.index ["city_id"], name: "index_flights_cities_on_city_id"
    t.index ["flight_id"], name: "index_flights_cities_on_flight_id"
  end

end
