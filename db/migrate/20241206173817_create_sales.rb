class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.decimal :total
      t.boolean :canceled
      t.string :client_name

      t.timestamps
    end
  end
end
