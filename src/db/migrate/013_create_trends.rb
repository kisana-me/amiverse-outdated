class CreateTrends < ActiveRecord::Migration[7.0]
  def change
    create_table :trends do |t|
      t.string :uuid, null: false
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.bigint :word_counter, null: false, default: 0
      t.bigint :search_counter, null: false, default: 0
      t.string :kind, null: false, default: ''
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :trends, [:uuid], unique: true
  end
end
