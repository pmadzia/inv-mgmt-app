class CreateInventories < ActiveRecord::Migration[8.1]
  DATA_TYPES = %w[string text int link bool].freeze

  def change
    create_table :inventories do |t|
      t.string :title, null: false
      t.text   :description
      t.string :image_url
      t.references :creator,  null: false, foreign_key: { to_table: :users }
      t.references :category, foreign_key: true
      t.jsonb :field_order,  null: false, default: []

      t.timestamps

      DATA_TYPES.each do |type|
        (1..3).each do |i|
          prefix = "custom_#{type}#{i}"
          t.boolean :"#{prefix}_state", null: false, default: false
          t.string  :"#{prefix}_name"
          t.string  :"#{prefix}_description"
          t.boolean :"#{prefix}_show", null: false, default: false
        end
      end
    end
    add_index :inventories, :created_at
  end
end
