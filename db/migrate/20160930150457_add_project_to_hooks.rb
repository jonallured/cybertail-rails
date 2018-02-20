class AddProjectToHooks < ActiveRecord::Migration[5.0]
  def change
    add_column :hooks, :project, :string
    # rubocop:disable Rails/SkipsModelValidations
    Hook.update_all project: 'temp'
    # rubocop:enable Rails/SkipsModelValidations
    change_column_null :hooks, :project, false
  end
end
