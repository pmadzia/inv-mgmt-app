class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  enum :blocked, { active: 0, blocked: 1 }, prefix: true
  enum :admin, { active: 0, admin: 1 }, prefix: true

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
end
