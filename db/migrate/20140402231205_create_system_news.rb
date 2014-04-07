class CreateSystemNews < ActiveRecord::Migration
  def change
    create_table :system_news do |t|
      t.string :title
      t.integer :user_id
      t.integer :role_id,       default: 0
      t.datetime :published_at
      t.string :tags,           null: true
      t.text :body

      t.timestamps
    end
  end
end
