class AddRoleidToForumCategory < ActiveRecord::Migration
  def change
    add_column :forum_categories, :role_id, :integer, default: 0
  end
end
