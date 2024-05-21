class CreateItemLists < ActiveRecord::Migration[7.0]
  def change
    create_table :item_lists do |t|
      t.references :account, null: false, foreign_key: true
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.integer :counter, null: false, default: 0
      t.integer :status, limit: 1, null: false, default: 0
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :item_lists, [:aid], unique: true
  end
end
