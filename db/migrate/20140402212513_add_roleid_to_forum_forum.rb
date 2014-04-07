class AddRoleidToForumForum < ActiveRecord::Migration
  def change
    add_column :forum_forums, :role_id, :integer, default: 0
  end
end
