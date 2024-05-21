class CreateEmojis < ActiveRecord::Migration[7.0]
  def change
    create_table :emojis do |t|
      t.references :account, null: false, foreign_key: true
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.string :name_id, null: false, default: ''
      t.text :description, null: false, default: ''
      t.integer :usage_type, limit: 1, null: false, default: 0
      t.boolean :sensitive, null: false, default: false
      t.string :caution_message, null: false, default: ''
      t.string :original_key, null: false, default: ''
      t.json :variants, null: false, default: []
      t.integer :status, limit: 1, null: false, default: 0
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :emojis, [:aid, :name_id], unique: true
  end
end
