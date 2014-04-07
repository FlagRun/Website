class AddGroupidToForumCategories < ActiveRecord::Migration
  def change
    add_column :forum_categories, :group_id, :integer, default: 0
  end
end
