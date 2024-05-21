class CreateAccountListRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :account_list_relations do |t|
      t.references :account, null: false, foreign_key: true
      t.references :account_list, null: false, foreign_key: true
      t.timestamps
    end
  end
end
