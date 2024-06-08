class CreateReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :replies do |t|
      t.bigint :replied_id, null: false, foreign_key: true
      t.bigint :replier_id, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :replies, :items, column: :replied_id
    add_foreign_key :replies, :items, column: :replier_id
  end
end
