class AddDeletedAtToForumsTopics < ActiveRecord::Migration
  def change
    add_column :forum_topics, :deleted_at, :datetime
    add_index :forum_topics, :deleted_at
  end
end
