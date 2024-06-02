class CreateAchievements < ActiveRecord::Migration[7.0]
  def change
    create_table :achievements do |t|
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.string :original_key, null: false, default: ''
      t.json :variants, null: false, default: []
      t.bigint :associated_counter, null: false, default: 0
      t.integer :status, limit: 1, null: false, default: 0
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :achievements, [:aid], unique: true
  end
end
