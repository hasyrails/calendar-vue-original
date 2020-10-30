# create_table "lists", force: :cascade do |t|
#   t.string "title"
#   t.integer "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["user_id"], name: "index_lists_on_user_id"
# end

json.array! @lists do |list|
  json.id list.id
  json.title list.title
  json.user_id  list.user_id
end
