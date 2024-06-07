class CreateServerProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :server_properties do |t|
      t.string :aid, null: false
      # server info
      t.string :server_name, null: false, default: ''
      t.string :server_version, null: false, default: ''
      t.text :server_description, null: false, default: ''
      # features
      t.boolean :open_registrations, null: false, default: false
      t.json :languages, null: false, default: []
      t.string :theme_color, null: false, default: ''
      t.json :urls, null: false, default: []
      t.json :others, null: false, default: []
      # maintainer
      t.string :maintainer_name, null: false, default: ''
      t.string :maintainer_email, null: false, default: ''
      # total numbers
      t.bigint :accounts, null: false, default: 0
      t.bigint :items, null: false, default: 0
      t.bigint :images, null: false, default: 0
      t.bigint :audios, null: false, default: 0
      t.bigint :videos, null: false, default: 0
      t.bigint :emojis, null: false, default: 0
      t.bigint :reactions, null: false, default: 0
      # other
      t.json :meta, null: false, default: {}
      t.datetime :published_at
      # activitypub
      t.boolean :activitypub, null: false, default: false
      t.json :ap_meta, null: false, default: {}
      t.timestamps
    end
  end
end
