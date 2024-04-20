class CreateEmojis < ActiveRecord::Migration[7.0]
  def change
    create_table :emojis do |t|
      t.references :account, null: false, foreign_key: true
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.string :name_id, null: false, default: ''
      t.text :description, null: false, default: ''
      t.boolean :custom, null: false, default: false
      t.boolean :official, null: false, default: false
      t.boolean :sensitive, null: false, default: false
      t.boolean :local, null: false, default: false
      t.boolean :scope, null: false, default: false
      t.boolean :limit, null: false, default: false
      t.boolean :private, null: false, default: false
      t.string :kind, null: false, default: ''
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :emojis, [:aid, :name_id], unique: true
  end
end
