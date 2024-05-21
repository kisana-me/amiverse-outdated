class CreateAccountIcons < ActiveRecord::Migration[7.0]
  def change
    create_table :account_icons do |t|
      t.references :account, null: false, foreign_key: true
      t.references :icon, null: false, foreign_key: true
      t.timestamps
    end
  end
end
