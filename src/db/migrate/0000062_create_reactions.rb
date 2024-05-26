class CreateReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reactions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :emoji, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :usage_type, limit: 1, null: false, default: 0
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
