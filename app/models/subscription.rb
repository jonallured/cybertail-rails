class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def hooks
    project.hooks.where(suppress: false)
  end
end
