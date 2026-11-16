class Item < ApplicationRecord
  belongs_to :inventory
  belongs_to :created_by, class_name: "User"

  validates :custom_id, presence: true, uniqueness: { scope: :inventory_id }

  def field_values
    inventory.active_fields.map { |field| [ field, self[field.key] ] }
  end
end
