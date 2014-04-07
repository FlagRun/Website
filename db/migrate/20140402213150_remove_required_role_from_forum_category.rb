class RemoveRequiredRoleFromForumCategory < ActiveRecord::Migration
  def change
    change_table :forum_categories do |t|
      t.remove :required_role
    end
  end
end
