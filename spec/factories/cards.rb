# create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
#   t.string "body"
#   t.text "description"
#   t.date "start"
#   t.date "deadline"
#   t.string "color"
#   t.boolean "schedulized", default: false, null: false
#   t.boolean "deadlined", default: false, null: false
#   t.boolean "done", default: false, null: false
#   t.bigint "list_id", null: false
#   t.date "done_at"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.bigint "user_id"
#   t.bigint "schedule_id"
#   t.index ["list_id"], name: "index_cards_on_list_id"
#   t.index ["schedule_id"], name: "index_cards_on_schedule_id"
#   t.index ["user_id"], name: "index_cards_on_user_id"
# end

FactoryBot.define do
  factory :card do
    sequence(:body) { |n| "TestCardBody#{n}" }
    sequence(:description) { |n| "TestCardDescription#{n}" }
    # image { File.open("#{Rails.root}/spec/fixtures/testicon.png") }
    # association :user
    # association :list
    # association :schedule
  end
end
