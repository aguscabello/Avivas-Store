class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :stock
      t.references :category, null: false, foreign_key: true
      t.references :color, null: true, foreign_key: true
      t.string :size
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
