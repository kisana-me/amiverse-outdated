class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.string :uuid, null: false
      t.string :model, null: false, default: ''
      t.string :aid, null: false, default: ''
      t.string :kind, null: false, default: ''
      t.json :data, null: false, default: []
      t.timestamps
    end
    add_index :logs, [:uuid], unique: true
  end
end
