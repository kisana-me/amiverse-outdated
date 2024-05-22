class CreateDiffusions < ActiveRecord::Migration[7.0]
  def change
    create_table :diffusions do |t|
      t.bigint :diffused, null: false, foreign_key: true
      t.bigint :diffuser, null: false, foreign_key: true
      t.timestamps
    end
    add_foreign_key :diffusions, :items, column: :diffused
    add_foreign_key :diffusions, :items, column: :diffuser
  end
end
