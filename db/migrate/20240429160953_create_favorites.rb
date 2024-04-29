class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.string :item_id
      t.integer :favorite_type
      t.string :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
