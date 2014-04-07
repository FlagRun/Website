class AddGroupToUsers < ActiveRecord::Migration
  def change
    add_column :users, :group_id, :integer, default: 0
    add_index  :users, :group_id
  end
end
