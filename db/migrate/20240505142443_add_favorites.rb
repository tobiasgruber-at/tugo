class AddFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table "favorites", force: :cascade do |t|
    t.string "item_id"
    t.integer "user_id", null: false
    t.integer "favorite_type", null: false
    t.string "preview", null: false
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "item_id"], name: "index_favorites_on_user_id", unique: true
    end

    add_foreign_key "favorites", "users"
  end
end
