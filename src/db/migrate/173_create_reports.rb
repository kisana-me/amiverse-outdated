class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :aid, null: false
      t.string :kind, null: false, default: ''
      t.string :object, null: false, default: ''
      t.string :object_id, null: false, default: ''
      t.text :content, null: false, default: ''
      t.string :contact, null: false, default: ''
      t.boolean :solved, null: false, default: false
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :reports, [:aid], unique: true
  end
end
