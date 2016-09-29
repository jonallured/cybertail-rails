class Hook < ActiveRecord::Base
  validates_presence_of :payload, :sent_at
end
