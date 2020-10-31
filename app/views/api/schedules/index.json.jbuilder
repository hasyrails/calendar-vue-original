# create_table "schedules", force: :cascade do |t|
#   t.string "body"
#   t.string "description"
#   t.date "start"
#   t.date "deadline"
#   t.boolean "done", default: false, null: false
#   t.boolean "deadlined", default: false, null: false
#   t.datetime "date"
#   t.integer "date_year"
#   t.integer "date_month"
#   t.integer "date_day"
#   t.boolean "commit", default: true, null: false
#   t.string "color"
#   t.integer "card_id", null: false
#   t.integer "user_id", null: false
#   t.date "done_at"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["card_id"], name: "index_schedules_on_card_id"
#   t.index ["user_id"], name: "index_schedules_on_user_id"
# end


json.array! @schedules do |schedule|
  json.id  schedule.id
  json.body  schedule.body
  json.description  schedule.description
  json.start  schedule.start
  json.deadline  schedule.deadline
  json.done  schedule.done
  json.deadlined  schedule.deadlined
  json.date  schedule.date
  json.date_year  schedule.date_year
  json.date_month  schedule.date_month
  json.date_day  schedule.date_day
  json.commit  schedule.commit
  json.color  schedule.color
  json.card_id  schedule.card_id
  json.user_id  schedule.user_id
  json.done_at  schedule.done_at
end
