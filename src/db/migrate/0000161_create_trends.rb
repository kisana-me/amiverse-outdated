class CreateTrends < ActiveRecord::Migration[7.0]
  def change
    create_table :trends do |t|
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      #t.bigint :counter, null: false, default: 0
      t.json :words, null: false, default: {}
      t.integer :status, limit: 1, null: false, default: 0
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.datetime :started_at
      t.datetime :ended_at
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :trends, [:aid], unique: true
  end
end
