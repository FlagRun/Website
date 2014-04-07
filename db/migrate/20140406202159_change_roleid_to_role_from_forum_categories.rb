class ChangeRoleidToRoleFromForumCategories < ActiveRecord::Migration
  def change
    rename_column :forum_categories, :role_id, :oline
  end
end
