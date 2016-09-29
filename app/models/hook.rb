class Hook < ActiveRecord::Base
  belongs_to :service
  validates_presence_of :payload, :sent_at
end
