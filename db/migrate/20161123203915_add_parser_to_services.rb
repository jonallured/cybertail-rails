class AddParserToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :parser, :string
  end
end
