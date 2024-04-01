class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.bigint :followed, null: false, foreign_key: true
      t.bigint :follower, null: false, foreign_key: true
      t.string :uuid, null: false, default: ''
      t.boolean :accepted, null: false, default: false
      t.datetime :accepted_at
      t.string :kind, null: false, default: ''
      t.json :meta, null: false, default: []
      t.json :cache, null: false, default: []
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_foreign_key :follows, :accounts, column: :followed
    add_foreign_key :follows, :accounts, column: :follower
  end
end
