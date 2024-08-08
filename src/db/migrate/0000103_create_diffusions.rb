class CreateDiffusions < ActiveRecord::Migration[7.0]
  def change
    create_table :diffusions do |t|
      t.bigint :diffused_id, null: false, foreign_key: true
      t.bigint :diffuser_id, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :diffusions, :items, column: :diffused_id
    add_foreign_key :diffusions, :accounts, column: :diffuser_id
  end
end
