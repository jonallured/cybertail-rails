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

  def self.newer_than_hook_for(user, newest_hook_id, limit=100)
    most_recent_for(user.id, limit).
      where("hooks.id > ?", newest_hook_id)
  end

  def self.up_to_bookmark_for(user, limit=100)
    most_recent_for(user.id, limit).
      where("hooks.created_at >= ?", user.bookmarked_at)
  end

  def service_id
    project.service.id
  end

  def project_name
    project.name
  end
end
