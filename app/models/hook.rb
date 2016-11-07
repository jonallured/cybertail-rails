class Hook < ApplicationRecord
  belongs_to :project
  validates_presence_of :payload, :sent_at

  def service_id
    project.service.id
  end

  def project_name
    project.name
  end
end
