class CreateForumTopics < ActiveRecord::Migration
  def change
    create_table :forum_topics do |t|
      t.string   :title
      t.integer  :hits, :default => 0
      t.boolean  :sticky, :default => false
      t.boolean  :locked, :default => false
      t.integer  :posts_count
      t.integer  :forum_id
      t.integer  :user_id

      t.timestamps
    end
  end
end
