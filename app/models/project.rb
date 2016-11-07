class Project < ApplicationRecord
  belongs_to :service
  has_many :hooks

  validates_presence_of :name
end
