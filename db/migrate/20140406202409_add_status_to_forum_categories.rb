class AddStatusToForumCategories < ActiveRecord::Migration
  def change
    add_column :forum_categories, :status, :integer, default: 1
  end
end
