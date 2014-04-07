class AddFlagsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :flags, :string, null: true, default: :null
  end
end
