class AddTokenToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :token, :string

    Project.all.each do |project|
      project.send(:set_token)
      project.save
    end

    change_column_null :projects, :token, false
  end
end
