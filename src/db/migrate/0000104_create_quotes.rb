class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.bigint :quoted_id, null: false, foreign_key: true
      t.bigint :quoter_id, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :quotes, :items, column: :quoted_id
    add_foreign_key :quotes, :items, column: :quoter_id
  end
end
