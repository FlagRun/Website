class RemoveRequiredRoleFromForumForum < ActiveRecord::Migration
  def change
    change_table :forum_forums do |t|
      t.remove :required_role
    end

  end


end
