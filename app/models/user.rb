class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  before_validation :set_token
  validates_presence_of :token

  private

  def set_token
    while self.token == nil || self.token.empty? do
      hex_token = SecureRandom.hex(32).upcase
      self.token = hex_token unless self.class.exists? token: hex_token
    end
  end
end
