class AddTtitleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string, default: ''
  end
end
