class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.bigint :followed_id, null: false, foreign_key: true
      t.bigint :follower_id, null: false, foreign_key: true
      t.string :uid, null: false, default: ''
      t.boolean :accepted, null: false, default: false
      t.datetime :accepted_at
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_foreign_key :follows, :accounts, column: :followed_id
    add_foreign_key :follows, :accounts, column: :follower_id
  end
end
