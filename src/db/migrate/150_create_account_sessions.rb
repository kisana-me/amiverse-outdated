class CreateAccountSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :account_sessions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :session, null: false, foreign_key: true
      t.string :name, null: false, default: ''
      t.string :ip_address, null: false, default: ''
      t.string :user_agent, null: false, default: ''
      t.boolean :current, null: false, default: false
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
