class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :uuid, null: false
      t.string :client_digest, null: false
      t.bigint :primary_session, null: false, default: 0
      t.string :name, null: false, default: ''
      t.string :ip_address, null: false, default: ''
      t.string :user_agent, null: false, default: ''
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :clients, [:uuid], unique: true
  end
end
