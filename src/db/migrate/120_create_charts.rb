class CreateCharts < ActiveRecord::Migration[7.0]
  def change
    create_table :charts do |t|
      t.string :uuid, null: false
      t.string :model, null: false, default: ''
      t.string :aid, null: false, default: ''
      t.string :kind, null: false, default: ''
      t.integer :counter, null: false, default: 0
      t.timestamps
    end
    add_index :charts, [:uuid], unique: true
  end
end
