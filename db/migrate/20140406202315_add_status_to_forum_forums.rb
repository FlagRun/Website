class AddStatusToForumForums < ActiveRecord::Migration
  def change
    add_column :forum_forums, :status, :integer, default: 1
  end
end
