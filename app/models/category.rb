class Category < ApplicationRecord
  has_many :inventories, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: true
end
