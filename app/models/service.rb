class Service < ActiveRecord::Base
  has_many :hooks
  validates_presence_of :name

  def self.heroku
    find_by name: 'Heroku'
  end

  def self.travis
    find_by name: 'Travis CI'
  end
end
