class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string   :name,            null: false
      t.string   :email,           null: false
      t.string   :password_digest, null: false
      t.integer  :blocked,         null: false, default: 0
      t.integer  :admin,           null: false, default: 0
      t.timestamps
    end
    add_index :users, :name
    add_index :users, :email, unique: true
  end
end
