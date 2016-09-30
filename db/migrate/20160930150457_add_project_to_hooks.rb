class AddProjectToHooks < ActiveRecord::Migration[5.0]
  def change
    add_column :hooks, :project, :string
    Hook.update_all project: 'temp'
    change_column_null :hooks, :project, false
  end
end
