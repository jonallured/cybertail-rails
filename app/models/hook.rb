class Hook < ActiveRecord::Base
  belongs_to :service
  validates_presence_of :payload, :project, :sent_at
end
