class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer, default: 1
    add_index :users, :status
  end
end
