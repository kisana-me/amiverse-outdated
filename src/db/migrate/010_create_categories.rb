class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.bigint :counter, null: false, default: 0
      t.string :kind, null: false, default: ''
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :categories, [:aid], unique: true
  end
end
