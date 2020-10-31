# create_table "cards", force: :cascade do |t|
#   t.string "body"
#   t.text "description"
#   t.date "start"
#   t.date "end"
#   t.integer "color"
#   t.boolean "schedulized", default: false, null: false
#   t.boolean "deadlined", default: false, null: false
#   t.boolean "done", default: false, null: false
#   t.integer "list_id", null: false
#   t.integer "user_id", null: false
#   t.date "done_at"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["list_id"], name: "index_cards_on_list_id"
#   t.index ["user_id"], name: "index_cards_on_user_id"
# end

FactoryBot.define do
  factory :card do
    id {"1"}
    body { "TestCard" }
    description { "TestCardDetail" }
    user_id { "1" }
    list_id { "1" }
  end
end
