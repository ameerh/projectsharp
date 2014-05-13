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

ActiveRecord::Schema.define(version: 20140513135225) do

  create_table "espn_games", force: true do |t|
    t.integer  "team_a"
    t.integer  "team_h"
    t.string   "time"
    t.date     "date"
    t.integer  "pitcher_a"
    t.integer  "pitcher_h"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
  end

  create_table "espn_team_stats", force: true do |t|
    t.string   "split"
    t.string   "GS"
    t.string   "R"
    t.string   "BA"
    t.string   "OBP"
    t.string   "SLG"
    t.string   "record"
    t.string   "position"
    t.integer  "espn_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "espn_teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "events", force: true do |t|
    t.datetime "event_datetime"
    t.integer  "gamenumber"
    t.string   "sporttype"
    t.string   "league"
    t.boolean  "is_live"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "odds", force: true do |t|
    t.integer  "moneyline_value"
    t.integer  "to_base"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.string   "participant_name"
    t.integer  "contestantnum"
    t.integer  "rotnum"
    t.string   "visiting_home_draw"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pitcher"
  end

  create_table "periods", force: true do |t|
    t.integer  "period_number"
    t.string   "period_description"
    t.datetime "periodcutoff_datetime"
    t.string   "period_status"
    t.string   "period_update"
    t.integer  "spread_maximum"
    t.integer  "moneyline_maximum"
    t.integer  "total_maximum"
    t.integer  "moneyline_visiting"
    t.integer  "moneyline_home"
    t.float    "spread_visiting"
    t.integer  "spread_adjust_visiting"
    t.float    "spread_home"
    t.integer  "spread_adjust_home"
    t.integer  "tootal_point"
    t.integer  "over_adjust"
    t.integer  "under_adjust"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitcher_home_aways", force: true do |t|
    t.string   "split"
    t.integer  "W"
    t.integer  "L"
    t.float    "ERA"
    t.float    "GS"
    t.float    "WHIP"
    t.integer  "pitcher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitcher_platoon_splits", force: true do |t|
    t.string   "split"
    t.string   "BA"
    t.integer  "pitcher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitcher_season_totals", force: true do |t|
    t.string   "split"
    t.integer  "W"
    t.integer  "L"
    t.float    "W_L"
    t.float    "ERA"
    t.integer  "G"
    t.integer  "GS"
    t.integer  "GF"
    t.integer  "CG"
    t.integer  "SHO"
    t.integer  "SV"
    t.integer  "IP"
    t.integer  "H"
    t.integer  "R"
    t.integer  "ER"
    t.integer  "HR"
    t.integer  "BB"
    t.integer  "IBB"
    t.integer  "SO"
    t.integer  "HBP"
    t.integer  "BK"
    t.integer  "WP"
    t.integer  "BF"
    t.float    "WHIP"
    t.float    "SOp"
    t.integer  "pitcher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitchers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "throws"
    t.float    "age"
    t.string   "full_name"
  end

  create_table "stat_ranks", force: true do |t|
    t.integer  "at_bats"
    t.integer  "runs_scored"
    t.integer  "hits"
    t.integer  "double_hit"
    t.integer  "triple_hit"
    t.integer  "home_run"
    t.integer  "stolen_base"
    t.integer  "caught_stealing"
    t.integer  "bases_balls"
    t.integer  "strikeout"
    t.integer  "ba"
    t.integer  "obp"
    t.integer  "slg"
    t.integer  "ops"
    t.integer  "total_bases"
    t.integer  "hbp"
    t.integer  "sf"
    t.integer  "team_stat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_stats", force: true do |t|
    t.integer  "game_played"
    t.integer  "runs_scored"
    t.float    "hits"
    t.float    "obp"
    t.float    "slg"
    t.string   "reacord"
    t.string   "position"
    t.integer  "espn_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
