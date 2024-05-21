class CreateTimelines < ActiveRecord::Migration[7.0]
  def change
    create_table :timelines do |t|
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      # poly ??
      t.integer :usage_type, limit: 1, null: false, default: 0
      t.integer :status, limit: 1, null: false, default: 0
      t.json :data, null: false, default: []
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
    add_index :timelines, [:aid], unique: true
  end
end
