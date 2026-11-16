class Inventory < ApplicationRecord
  DATA_TYPES = %w[string text int link bool].freeze
  ALL_FIELDS = DATA_TYPES.flat_map { |type|
    (1..3).map { |n| [ "custom_#{type}#{n}", type ] }
  }.freeze

  Field = Struct.new(:key, :type, :name, :description, :show, keyword_init: true)

  belongs_to :creator, class_name: "User"
  belongs_to :category, optional: true
  validates :title, presence: true
  validate  :validate_field_names
  has_many :items, dependent: :destroy

  def find_active_fields
    ALL_FIELDS.select { |key, _type| self[:"#{key}_state"] }
              .map    { |key, type| build_field(key, type) }
              .sort_by { |field| find_position_of(field.key) }
  end

  def find_table_fields
    find_active_fields.select(&:show)
  end

  def find_free_slot_for(type)
    (1..3).map { |n| "custom_#{type}#{n}" }
          .find { |key| !self[:"#{key}_state"] }
  end

  def add_field(type:, name:, description: nil, show: false)
      key = free_slot_for(type) or return false
      assign_attributes("#{key}_state" => true, "#{key}_name" => name,
                        "#{key}_description" => description, "#{key}_show" => show)
      self.field_order += [ key ]
      true
  end

  def remove_field(key)
    assign_attributes("#{key}_state" => false, "#{key}_name" => nil,
                      "#{key}_description" => nil, "#{key}_show" => false)
    self.field_order -= [ key ]
  end

  private

  def build_field(key, type)
    Field.new(key: key, type: type, name: self[:"#{key}_name"],
              description: self[:"#{key}_description"], show: self[:"#{key}_show"])
  end

  def find_position_of(key)
    field_order.index(key) || field_order.size
  end

  def validate_field_names
    active_fields.each do |field|
      errors.add(:base, "Field #{field.key} needs a name") if field.name.blank?
    end
  end
end
