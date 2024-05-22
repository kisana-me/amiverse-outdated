class CreateAccountPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :account_permissions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true
      t.timestamps
    end
  end
end
