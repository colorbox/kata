class AddStatusColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :int, default: 0, null: false
  end
end
