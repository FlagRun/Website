class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.text     :body
      t.integer  :forum_id
      t.integer  :topic_id
      t.integer  :user_id

      t.timestamps
    end
  end
end
