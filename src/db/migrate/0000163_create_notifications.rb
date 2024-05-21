class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :account, null: false, foreign_key: true
      t.string :uuid, null: false
      # poly ??
      t.string :message, null: false, default: ''
      t.integer :status, limit: 1, null: false, default: 0
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
