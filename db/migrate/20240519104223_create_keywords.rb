class CreateKeywords < ActiveRecord::Migration[7.1]
  def change
    create_table :keywords, force: :cascade do |t|
      t.string :title, null: false
      t.references :favorite, null: false, foreign_key: true

      t.timestamps
    end
  end
end
