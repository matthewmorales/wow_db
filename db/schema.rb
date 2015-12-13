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

ActiveRecord::Schema.define(version: 20151213092459) do

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
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "level"
    t.string   "gender"
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
    t.integer  "title_id"
    t.integer  "mount_id"
    t.integer  "trinket_id"
    t.integer  "ring_id"
    t.integer  "neckpiece_id"
  end

  create_table "characters_mounts", id: false, force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "mount_id",     null: false
  end

  add_index "characters_mounts", ["character_id", "mount_id"], name: "index_characters_mounts_on_character_id_and_mount_id", using: :btree
  add_index "characters_mounts", ["mount_id", "character_id"], name: "index_characters_mounts_on_mount_id_and_character_id", using: :btree

  create_table "characters_titles", id: false, force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "title_id",     null: false
  end

  add_index "characters_titles", ["character_id", "title_id"], name: "index_characters_titles_on_character_id_and_title_id", using: :btree
  add_index "characters_titles", ["title_id", "character_id"], name: "index_characters_titles_on_title_id_and_character_id", using: :btree

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

  create_table "mounts", force: :cascade do |t|
    t.string   "name"
    t.boolean  "isFlying"
    t.boolean  "isGround"
    t.boolean  "isAquatic"
    t.boolean  "isJumping"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "spellId"
  end

  create_table "neckpieces", force: :cascade do |t|
    t.string   "name"
    t.string   "icon"
    t.integer  "quality"
    t.integer  "itemLevel"
    t.integer  "armor"
    t.string   "context"
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

  create_table "rings", force: :cascade do |t|
    t.string   "name"
    t.string   "icon"
    t.integer  "quality"
    t.integer  "itemLevel"
    t.integer  "armor"
    t.string   "context"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer  "character_id"
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

  create_table "titles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trinkets", force: :cascade do |t|
    t.string   "name"
    t.integer  "quality"
    t.integer  "itemLevel"
    t.integer  "armor"
    t.string   "context"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "characters", "armors"
  add_foreign_key "characters", "guilds"
  add_foreign_key "characters", "mainhands"
  add_foreign_key "characters", "mounts"
  add_foreign_key "characters", "neckpieces"
  add_foreign_key "characters", "offhands"
  add_foreign_key "characters", "rings"
  add_foreign_key "characters", "stats"
  add_foreign_key "characters", "tabards"
  add_foreign_key "characters", "titles"
  add_foreign_key "characters", "trinkets"
  add_foreign_key "stats", "characters"
end
