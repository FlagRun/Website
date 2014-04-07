class CreateForumForums < ActiveRecord::Migration
  def change
    create_table :forum_forums do |t|
      t.string   :title
      t.text     :description
      t.boolean  :state, :default => true
      t.integer  :topics_count, :default => 0
      t.integer  :posts_count, :default => 0
      t.integer  :position, :default => 0
      t.integer  :category_id
      t.string   :required_role

      t.timestamps
    end
  end
end
