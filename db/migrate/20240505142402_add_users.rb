class AddUsers < ActiveRecord::Migration[7.1]
  def change
    create_table "users", force: :cascade do |t|
      t.string "email", null: false
      t.string "password", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
