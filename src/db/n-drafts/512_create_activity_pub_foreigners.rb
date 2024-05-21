class CreateActivityPubForeigners < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_pub_foreigners do |t|
      t.references :account, null: false, foreign_key: true
      t.references :activity_pub_server, foreign_key: true
      t.timestamps
    end
  end
end
