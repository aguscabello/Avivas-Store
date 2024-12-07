class AddPreviousPasswordToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :previous_password, :string
  end
end
