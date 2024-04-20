class CreateTimelines < ActiveRecord::Migration[7.0]
  def change
    create_table :timelines do |t|
      t.string :uuid, null: false
      t.string :model, null: false, default: ''
      t.string :aid, null: false, default: ''
      t.string :kind, null: false, default: ''
      t.json :data, null: false, default: []
      t.timestamps
    end
    add_index :timelines, [:uuid], unique: true
  end
end
