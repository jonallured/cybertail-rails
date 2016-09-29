class CreateHooks < ActiveRecord::Migration[5.0]
  def change
    create_table :hooks do |t|
      t.belongs_to :service
      t.json :payload, null: false
      t.string :message
      t.string :url
      t.datetime :sent_at, null: false
      t.timestamps
    end
  end
end
