# create_table "lists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
#   t.string "title"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.bigint "user_id"
#   t.index ["user_id"], name: "index_lists_on_user_id"
# end

FactoryBot.define do
  factory :list do
    sequence(:title) { |n| "TestList#{n}" }
    # association :user
  end
end

  