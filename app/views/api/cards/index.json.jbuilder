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


json.array! @cards do |card|
  json.id card.id
  json.body card.body
  json.description card.description
  json.start  card.start
  json.end  card.end
  json.color  card.color
  json.schedulized  card.schedulized
  json.deadlined  card.deadlined
  json.done  card.done
  json.list_id  card.list_id
  json.user_id  card.user_id
  json.done_at  card.done_at
end
