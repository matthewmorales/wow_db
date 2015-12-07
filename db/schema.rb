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

ActiveRecord::Schema.define(version: 20151207064342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "armors", force: :cascade do |t|
    t.string   "name"
    t.integer  "quality"
    t.integer  "itemLevel"
    t.integer  "armor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "context"
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.string   "locale"
    t.string   "realm"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "level"
    t.string   "gender",              limit: 1
    t.integer  "char_class"
    t.integer  "race"
    t.integer  "achievements_points"
    t.integer  "honorable_kills"
    t.string   "battle_group"
    t.string   "faction"
    t.integer  "guild_id"
    t.integer  "armor_id"
    t.integer  "tabard_id"
    t.integer  "mainhand_id"
    t.integer  "offhand_id"
    t.integer  "stat_id"
  end

  create_table "guilds", force: :cascade do |t|
    t.string   "name"
    t.string   "realm"
    t.string   "battlegroup"
    t.integer  "members"
    t.integer  "achievementPoints"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "mainhands", force: :cascade do |t|
    t.string   "name"
    t.integer  "quality"
    t.integer  "itemLevel"
    t.string   "context"
    t.float    "dps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offhands", force: :cascade do |t|
    t.string   "name"
    t.integer  "quality"
    t.integer  "itemLevel"
    t.integer  "armor"
    t.string   "context"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "dps"
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "health"
    t.string   "powerType"
    t.integer  "power"
    t.integer  "str"
    t.integer  "agi"
    t.integer  "int"
    t.integer  "sta"
    t.float    "crit"
    t.float    "haste"
    t.float    "mastery"
    t.integer  "bonusArmor"
    t.integer  "spellPower"
    t.integer  "armor"
    t.float    "parry"
    t.float    "block"
    t.integer  "attackPower"
    t.float    "mainHandDps"
    t.integer  "rangedAttackPower"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "tabards", force: :cascade do |t|
    t.string   "name"
    t.integer  "quality"
    t.integer  "itemLevel"
    t.string   "context"
    t.integer  "armor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "characters", "armors"
  add_foreign_key "characters", "guilds"
  add_foreign_key "characters", "mainhands"
  add_foreign_key "characters", "offhands"
  add_foreign_key "characters", "stats"
  add_foreign_key "characters", "tabards"
end
