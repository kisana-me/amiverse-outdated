class CreateIcons < ActiveRecord::Migration[7.0]
  def change
    create_table :icons do |t|
      t.references :account, null: false, foreign_key: true
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.boolean :sensitive, null: false, default: false
      t.string :caution_message, null: false, default: ''
      t.boolean :scoping, null: false, default: false
      t.boolean :limiting, null: false, default: false
      t.boolean :private, null: false, default: false
      t.string :original_key, null: false, default: ''
      t.json :variants, null: false, default: []
      t.integer :status, limit: 1, null: false, default: 0
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.bigint :data_size, null: false, default: 0
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :icons, [:aid], unique: true
  end
end
