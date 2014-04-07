class CreateForumCategories < ActiveRecord::Migration
  def change
    create_table :forum_categories do |t|
      t.string   :title
      t.boolean  :state, :default => true
      t.integer  :position, :default => 0
      t.string   :required_role

      t.timestamps
    end
  end
end
