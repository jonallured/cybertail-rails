class AddSuppressionToHooks < ActiveRecord::Migration[5.0]
  def change
    add_column :hooks, :suppress, :boolean, null: false, default: false
  end
end
