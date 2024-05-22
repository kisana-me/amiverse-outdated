class CreateAnnouncements < ActiveRecord::Migration[7.0]
  def change
    create_table :announcements do |t|
      t.string :aid, null: false
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.integer :counter, null: false, default: 0
      t.boolean :private, null: false, default: false
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :announcements, [:aid], unique: true
  end
end
