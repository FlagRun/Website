class ChangeRoleidFromForumForum < ActiveRecord::Migration
  def change
    rename_column :forum_forums, :role_id, :oline
  end
end
