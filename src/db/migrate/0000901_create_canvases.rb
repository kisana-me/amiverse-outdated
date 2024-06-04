class CreateCanvases < ActiveRecord::Migration[7.0]
  def change
    create_table :canvases do |t|
      t.references :account, null: false, foreign_key: true
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.integer :render_type, limit: 1, null: false, default: 0
      t.json :canvas_data, null: false, default: []
      t.integer :canvas_type, limit: 1, null: false, default: 0
      t.boolean :sensitive, null: false, default: false
      t.string :caution_message, null: false, default: ''
      t.string :original_key, null: false, default: ''
      t.json :variants, null: false, default: []
      t.integer :visibility, limit: 1, null: false, default: 0
      t.integer :limitation, limit: 1, null: false, default: 0
      t.integer :status, limit: 1, null: false, default: 0
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.bigint :data_size, null: false, default: 0
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :canvases, [:aid], unique: true
  end
end
