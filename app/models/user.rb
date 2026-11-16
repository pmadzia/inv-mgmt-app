class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :inventories, foreign_key: :creator_id, inverse_of: :creator, dependent: :destroy
  has_many :items, foreign_key: :created_by_id, inverse_of: :created_by, dependent: :restrict_with_error

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :status, { active: 0, blocked: 1 }
  enum :role, { user: 0, admin: 1 }

  validates :name, presence: true
  validates :email_address, presence: true,
                            uniqueness: { message: :already_in_use },
                            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, allow_nil: true

  def self.from_omniauth(response)
    find_or_create_by(uid: response[:uid], provider: response[:provider]) do |user|
      user.name = response.dig(:info, :name)
      user.email_address = response.dig(:info, :email)
      user.password = SecureRandom.hex(16)
    end
  end

  def self.ransackable_attributes(_auth = nil)
    %w[name email_address status role created_at]
  end

  def self.ransackable_associations(_auth = nil)
    []
  end
end
