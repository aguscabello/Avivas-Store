class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :phone, :string, null: false
    add_column :users, :role, :string, null: false, default: "employee"
    add_column :users, :joining_date, :date, null: false
    add_column :users, :active, :boolean, default: true

    add_index :users, :username, unique: true
  end
end
