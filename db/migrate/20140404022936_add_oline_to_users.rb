class AddOlineToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oline, :integer, default: 0
  end
end
