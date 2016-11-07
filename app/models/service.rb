class Service < ApplicationRecord
  has_many :projects
  validates_presence_of :name

  def self.circle
    find_by name: 'Circle CI'
  end

  def self.github
    find_by name: 'GitHub'
  end

  def self.heroku
    find_by name: 'Heroku'
  end

  def self.honeybadger
    find_by name: 'Honeybadger'
  end

  def self.travis
    find_by name: 'Travis CI'
  end
end
