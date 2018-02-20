class Service < ApplicationRecord
  has_many :projects
  has_many :hooks
end

class Project < ApplicationRecord
  belongs_to :service
  has_many :hooks
end

class Hook < ApplicationRecord
  belongs_to :service
  belongs_to :project
end

class CreateProjects < ActiveRecord::Migration[5.0]
  # rubocop:disable Metrics/AbcSize
  def up
    rename_column :hooks, :project, :project_name

    create_table :projects do |t|
      t.belongs_to :service
      t.string :name
      t.timestamps
    end

    add_column :hooks, :project_id, :integer

    Service.all.each do |service|
      service.hooks.each do |hook|
        project = service.projects.find_or_create_by name: hook.project_name
        hook.update_attributes project: project
      end
    end

    remove_column :hooks, :service_id
    remove_column :hooks, :project_name
  end
  # rubocop:enable Metrics/AbcSize

  def down
    add_column :hooks, :project_name, :string
    add_column :hooks, :service_id, :integer

    Project.all.each do |project|
      project.hooks.each do |hook|
        attrs = {
          service: project.service,
          project_name: project.name
        }

        hook.update_attributes attrs
      end
    end

    remove_column :hooks, :project_id

    drop_table :projects

    rename_column :hooks, :project_name, :project
  end
end
