class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  has_many :subscriptions, dependent: :destroy

  before_validation :set_token
  validates :token, presence: true

  private

  def set_token
    while token.blank?
      hex_token = SecureRandom.hex(32).upcase
      self.token = hex_token unless self.class.exists? token: hex_token
    end
  end
end
