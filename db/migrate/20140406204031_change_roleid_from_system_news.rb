class ChangeRoleidFromSystemNews < ActiveRecord::Migration
  def change
    rename_column :system_news, :role_id, :oline
  end
end
