# create_table "schedules", force: :cascade do |t|
#   t.string "body"
#   t.string "description"
#   t.date "start"
#   t.date "end"
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


FactoryBot.define do
  factory :schedule do
    sequence(:body) { |n| "TestScheduleBody#{n}" }
    sequence(:description) { |n| "TestScheduleDescription#{n}" }
    # association :user
    # association :card
  end
end
