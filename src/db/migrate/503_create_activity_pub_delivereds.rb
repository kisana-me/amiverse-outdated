class CreateActivityPubDelivereds < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_pub_delivereds do |t|
      t.references :activity_pub_server, foreign_key: true
      t.string :to_url
      t.string :digest
      t.text :to_be_signed
      t.text :signature
      t.text :statement
      t.json :content
      t.text :response

      t.timestamps
    end
  end
end
