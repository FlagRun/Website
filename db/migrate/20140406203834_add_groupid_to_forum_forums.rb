class AddGroupidToForumForums < ActiveRecord::Migration
  def change
    add_column :forum_forums, :group_id, :integer, default: 0
  end
end
