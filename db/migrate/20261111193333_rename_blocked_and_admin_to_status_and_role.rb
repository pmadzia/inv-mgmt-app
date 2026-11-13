class RenameBlockedAndAdminToStatusAndRole < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :blocked, :status
    rename_column :users, :admin, :role
  end
end
