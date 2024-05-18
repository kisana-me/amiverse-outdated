class CreateCustomEmojis < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_emojis do |t|
      t.references :account, null: false, foreign_key: true
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.string :name_id, null: false, default: ''
      t.text :description, null: false, default: ''
      t.boolean :official, null: false, default: false
      t.boolean :sensitive, null: false, default: false
      t.boolean :local, null: false, default: false
      t.boolean :scoping, null: false, default: false
      t.boolean :limiting, null: false, default: false
      t.boolean :private, null: false, default: false
      t.string :license, null: false, default: ''
      t.integer :status, limit: 1, null: false, default: 0
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :custom_emojis, [:aid, :name_id], unique: true
  end
end
