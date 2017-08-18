class Hook < ApplicationRecord
  belongs_to :project
  validates_presence_of :payload, :sent_at

  def self.most_recent_for(user_id, limit=100)
    joins(project: :subscriptions).
      where("subscriptions.user_id = ?", user_id).
      where(suppress: false).
      order(created_at: :desc).
      limit(limit)
  end

  def service_id
    project.service.id
  end

  def project_name
    project.name
  end
end
