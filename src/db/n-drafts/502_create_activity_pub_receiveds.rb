class CreateActivityPubReceiveds < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_pub_receiveds do |t|
      t.references :activity_pub_server, foreign_key: true
      t.string :received_at
      t.json :headers
      t.json :body
      t.string :activitypub_id
      t.string :activity_type
      t.json :object
      t.string :status

      t.timestamps
    end
  end
end
