class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.references :inventory, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.string :custom_id, null: false

      t.timestamps

      (1..3).each do |n|
        t.string  :"custom_string#{n}"
        t.text    :"custom_text#{n}"
        t.decimal :"custom_int#{n}"
        t.string  :"custom_link#{n}"
        t.boolean :"custom_bool#{n}"
      end
    end
    add_index :items, [ :inventory_id, :custom_id ], unique: true
  end
end
